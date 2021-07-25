# == Schema Information
#
# Table name: pipelines
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_pipelines_on_account_id  (account_id)
#  index_pipelines_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (user_id => users.id)
#
class Pipeline < ApplicationRecord
  acts_as_tenant :account
  belongs_to :account
  belongs_to :user

  validates :name, presence: true
  has_many :sources
end
