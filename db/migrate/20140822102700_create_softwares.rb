class CreateSoftwares < ActiveRecord::Migration
  def change
    create_table :softwares do |t|
      t.integer :company_id
      t.integer :software_type_id
      t.text :description
      t.string :product_name
      t.string :manufacturer
      t.integer :vendor_id
      t.float :cost
      t.integer :license_years
      t.integer :license_months
      t.date :installation_date
      t.date :license_expiry_date
      t.string :license_key
      t.float :version
      t.integer :license_type_id
      t.string :installation_path
      t.date :last_audit_date
      t.integer :location_id
      t.integer :department_id
      t.integer :asset_manager_id
      t.integer :asset_user_id
      t.date :assigned_on

      t.timestamps
    end

      add_index :softwares, :company_id
      add_index :softwares, :software_type_id
      add_index :softwares, :vendor_id
      add_index :softwares, :license_type_id
      add_index :softwares, :department_id
      add_index :softwares, :location_id
      add_index :softwares, :asset_manager_id
      add_index :softwares, :asset_user_id      

  end
end
