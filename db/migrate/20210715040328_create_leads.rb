class CreateLeads < ActiveRecord::Migration[6.1]
  def change
    create_table :leads do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :address
      t.string :address2
      t.string :city
      t.string :address_state
      t.string :zip_code
      t.references :user, null: false, foreign_key: true
      t.references :source, null: false, foreign_key: true
      t.references :account, null: false, foreign_key: true
      t.boolean :marketing_accepted

      t.timestamps
    end
  end
end
