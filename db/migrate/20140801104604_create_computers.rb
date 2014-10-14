class CreateComputers < ActiveRecord::Migration
  def change
    create_table :computers do |t|
      t.string :serial      
      t.string :ip
      t.integer :computer_category_id
      t.integer :asset_status_id
      t.integer :operating_system_id
      t.string :os_ver_ser
      t.float :memory
      t.float :disk_space
      t.float :cpu_speed
      t.float :cpu_core_count
      t.string :mac
      t.float :cost
      t.date :acquisition_date
      t.date :expiry_date
      t.date :last_audit_date
      t.date :assigned_on
      t.integer :vendor_id
      t.integer :contract_id

      t.timestamps
    end

    add_index :computers, :computer_category_id
    add_index :computers, :asset_status_id
    add_index :computers, :operating_system_id
    add_index :computers, :vendor_id
    add_index :computers, :contract_id

  end
end
