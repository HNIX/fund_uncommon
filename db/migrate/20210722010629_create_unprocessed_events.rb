class CreateUnprocessedEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :unprocessed_events do |t|
      t.string :remote_ip
      t.json :payload
      t.string :stream_status
      t.references :source, null: false, foreign_key: true

      t.timestamps
    end
  end
end
