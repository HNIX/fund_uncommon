class CreateSources < ActiveRecord::Migration[6.1]
  def change
    create_table :sources do |t|
      t.references :pipeline, null: false, foreign_key: true
      t.string :url
      t.jsonb :state
      t.jsonb :intent
      t.jsonb :schema
      t.string :type
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
