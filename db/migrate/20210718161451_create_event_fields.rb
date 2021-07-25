class CreateEventFields < ActiveRecord::Migration[6.1]
  def change
    create_table :event_fields do |t|
      t.string :field_name
      t.string :target_field_name
      t.string :target_data_type
      t.string :data_type
      t.string :example_value
      t.references :field_set, null: false, foreign_key: true

      t.timestamps
    end
  end
end
