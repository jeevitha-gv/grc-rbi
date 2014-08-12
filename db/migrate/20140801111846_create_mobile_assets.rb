class CreateMobileAssets < ActiveRecord::Migration
  def change
    create_table :mobile_assets do |t|
      t.integer :company_id
      t.string :model
      t.string :manufacturer
      t.string :serial_number
      t.string :service_provider
      t.string :imei
      t.text :description
      t.integer :device_type_id
      t.integer :location_id
      t.integer :department_id

      t.timestamps
    end

    add_index :mobile_assets, :company_id
    add_index :mobile_assets, :device_type_id
    add_index :mobile_assets, :location_id
    add_index :mobile_assets, :department_id

  end
end
