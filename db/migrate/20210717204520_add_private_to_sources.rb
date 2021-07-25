class AddPrivateToSources < ActiveRecord::Migration[6.1]
  def change
    add_column :sources, :private, :boolean
  end
end
