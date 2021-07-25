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
require "test_helper"

class UnprocessedEventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
