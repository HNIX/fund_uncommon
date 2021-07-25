class AddLastUsedAtToSource < ActiveRecord::Migration[6.1]
  def change
    add_column :sources, :last_used_at, :datetime
  end
end
