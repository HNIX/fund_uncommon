class CreateFieldSets < ActiveRecord::Migration[6.1]
  def change
    create_table :field_sets do |t|
      t.references :source, null: false, foreign_key: true
      t.string :source_type

      t.timestamps
    end
  end
end
