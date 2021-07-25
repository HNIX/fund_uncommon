class AddSourceTypeToSource < ActiveRecord::Migration[6.1]
  def change
    add_column :sources, :source_type, :string
  end
end
