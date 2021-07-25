# == Schema Information
#
# Table name: event_fields
#
#  id                :bigint           not null, primary key
#  data_type         :string
#  example_value     :string
#  field_name        :string
#  last_used_at      :datetime
#  target_data_type  :string
#  target_field_name :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  field_set_id      :bigint           not null
#  parent_field_id   :bigint
#
# Indexes
#
#  index_event_fields_on_field_set_id     (field_set_id)
#  index_event_fields_on_parent_field_id  (parent_field_id)
#
# Foreign Keys
#
#  fk_rails_...  (field_set_id => field_sets.id)
#
require "test_helper"

class EventFieldTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
