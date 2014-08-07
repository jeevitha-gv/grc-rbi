class CreateOtherAssets < ActiveRecord::Migration
  def change
    create_table :other_assets do |t|
      t.integer :company_id
      t.string :name
      t.string :manufacturer
      t.integer :asset_type_id
      t.integer :asset_status_id
      t.string :model
      t.string :serial_number
      t.integer :asset_id
      t.string :ip
      t.text :description
      t.integer :asset_owner
      t.integer :asset_user
      t.integer :location_id
      t.integer :department_id
      t.integer :maintenance_contract
      t.integer :lease_contract

      t.timestamps
    end
    add_index :other_assets, :company_id
    add_index :other_assets, :location_id
    add_index :other_assets, :department_id
    add_index :other_assets, :asset_type_id
    add_index :other_assets, :asset_status_id
    add_index :other_assets, :asset_owner
    add_index :other_assets, :asset_user
    add_index :other_assets, :maintenance_contract
    add_index :other_assets, :lease_contract
  end
end
