# == Schema Information
#
# Table name: field_sets
#
#  id          :bigint           not null, primary key
#  source_type :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  source_id   :bigint           not null
#
# Indexes
#
#  index_field_sets_on_source_id  (source_id)
#
# Foreign Keys
#
#  fk_rails_...  (source_id => sources.id)
#
class FieldSet < ApplicationRecord
  
  belongs_to :source
  has_many :event_fields
end
