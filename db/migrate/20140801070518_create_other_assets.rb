class CreateOtherAssets < ActiveRecord::Migration
  def change
    create_table :other_assets do |t|
      t.string :manufacturer
      t.integer :asset_type_id
      t.integer :asset_status_id
      t.string :model
      t.string :serial_number
      t.integer :asset_id
      t.string :ip
      t.integer :maintenance_contract
      t.integer :lease_contract

      t.timestamps
    end
    add_index :other_assets, :asset_type_id
    add_index :other_assets, :asset_status_id
    add_index :other_assets, :maintenance_contract
    add_index :other_assets, :lease_contract
  end
end
