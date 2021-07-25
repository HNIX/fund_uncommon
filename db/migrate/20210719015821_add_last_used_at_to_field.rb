class AddLastUsedAtToField < ActiveRecord::Migration[6.1]
  def change
    add_column :event_fields, :last_used_at, :datetime
  end
end
