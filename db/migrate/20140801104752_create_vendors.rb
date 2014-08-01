class CreateVendors < ActiveRecord::Migration
  def change
    create_table :vendors do |t|
      t.integer :company_id
      t.string :name
      t.integer :reseller_type_id
      t.string :contact_name
      t.string :contact_email
      t.string :contact_phone
      t.string :url
      t.string :telephone
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :note

      t.timestamps
    end

    add_index :vendors, :company_id
    add_index :vendors, :reseller_type_id    

  end
end
