# == Schema Information
#
# Table name: sources
#
#  id            :bigint           not null, primary key
#  desc          :string
#  intent        :jsonb
#  last_used_at  :datetime
#  name          :string
#  private       :boolean
#  schema        :jsonb
#  source_type   :string
#  state         :jsonb
#  type          :string
#  url           :string
#  webhook_token :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  pipeline_id   :bigint           not null
#  user_id       :bigint           not null
#
# Indexes
#
#  index_sources_on_pipeline_id  (pipeline_id)
#  index_sources_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (pipeline_id => pipelines.id)
#  fk_rails_...  (user_id => users.id)
#
class Source < ApplicationRecord
  belongs_to :pipeline
  belongs_to :user
  has_many :leads
  has_one :field_set
  has_many :unprocessed_events

  validates :name, presence: true
  validates :private, presence: true

  validates_presence_of :webhook_token

  OPTIONS = [['Form Widget', 'form'], ['Webhook', 'webhook'], ['API', 'api'], ['Direct Upload', 'upload']]

  validates :source_type, inclusion: { in: %w(form webhook api upload), message: "%{value} is not a valid source type" }
  validates_presence_of :source_type

  before_validation(on: :create) do
    generate_webhook_token
  end

  def has_valid_field_mapping? 
    self.field_set.event_fields.each do |field|
      if field.has_mapping_errors? || field.has_type_errors?
        return false
      end
    end

    return true
  end

  private

    # Generate simple random salt
    def random_salt(len = 20)
      chars = ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a
      salt = ''
      1.upto(len) { |i| salt << chars[rand(chars.size-1)] }
      salt
    end

    # SHA1 with user_id, random salt and time
    def generate_webhook_token
      webhook_token = nil
      loop do
        webhook_token = Digest::SHA1.hexdigest("#{user_id}#{random_salt}#{Time.now.to_i}")
        if Source.where(webhook_token: webhook_token).first.blank?
          break
        end
      end
      self.webhook_token = webhook_token
    end

    
end
