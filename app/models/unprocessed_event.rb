# == Schema Information
#
# Table name: unprocessed_events
#
#  id            :bigint           not null, primary key
#  payload       :json
#  remote_ip     :string
#  stream_status :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  source_id     :bigint           not null
#
# Indexes
#
#  index_unprocessed_events_on_source_id  (source_id)
#
# Foreign Keys
#
#  fk_rails_...  (source_id => sources.id)
#
class UnprocessedEvent < ApplicationRecord
  after_commit :process_event, on: [:create]
  belongs_to :source

  private

  def process_event
    ProcessEventJob.perform_later(self.id)
  end
  
end
