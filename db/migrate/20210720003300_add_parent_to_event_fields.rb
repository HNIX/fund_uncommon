class AddParentToEventFields < ActiveRecord::Migration[6.1]
  disable_ddl_transaction!

  def change
    add_reference :event_fields, :parent_field, index: {algorithm: :concurrently}
  end
end
