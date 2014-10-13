class CreateSoftwares < ActiveRecord::Migration
  def change
    create_table :softwares do |t|
      t.integer :software_type_id
      t.string :product_name
      t.string :manufacturer
      t.integer :vendor_id
      t.float :cost
      t.date :installation_date
      t.date :license_expiry_date
      t.string :license_key
      t.float :version
      t.integer :license_type_id
      t.string :installation_path
      t.date :last_audit_date
      t.date :assigned_on

      t.timestamps
    end

      
      add_index :softwares, :software_type_id
      add_index :softwares, :vendor_id
      add_index :softwares, :license_type_id
           

  end
end
