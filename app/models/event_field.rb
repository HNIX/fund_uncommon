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
class EventField < ApplicationRecord
  
  belongs_to :field_set
  
  belongs_to :parent_field, class_name: 'EventField', optional: true
  has_many :sub_fields, class_name: 'EventField', foreign_key: "parent_field_id"


  OPTIONS = Lead.column_names

  validates :target_field_name, inclusion: { in: OPTIONS, message: "%{value} is not a valid field name" }, allow_blank: true,
    unless: Proc.new { |a| a.target_field_name.blank? }
  validates :target_field_name, uniqueness: { scope: :field_set_id,
    message: "field already mapped" }, unless: Proc.new { |a| a.target_field_name.blank? }

  def has_mapping_errors?
    errors = 0 
    
    if self.data_type == "parent"
      self.sub_fields.each do |sub_field|
        if sub_field.has_mapping_errors?
          errors += 1
        end  
      end
    elsif !self.target_field_name.present?
      errors += 1
    end

    !errors.zero?

  end

  def has_type_errors?
    errors = 0 
   
    if self.data_type == "parent"
      self.sub_fields.each do |sub_field|
        if sub_field.has_type_errors?
          errors += 1
        end  
      end
    elsif self.data_type == "trueclass" || self.data_type == "falseclass"
      unless self.target_data_type == "boolean"
        errors += 1
      end
    elsif self.data_type != self.target_data_type
      errors += 1
    end

    !errors.zero?

  end

end
