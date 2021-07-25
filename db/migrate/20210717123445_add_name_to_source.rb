class AddNameToSource < ActiveRecord::Migration[6.1]
  def change
    add_column :sources, :name, :string
    add_column :sources, :desc, :string
    add_column :sources, :webhook_token, :string
  end
end
