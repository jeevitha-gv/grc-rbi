class CreateMobileAssets < ActiveRecord::Migration
  def change
    create_table :mobile_assets do |t|

      t.string :model
      t.string :manufacturer
      t.string :serial_number
      t.string :service_provider
      t.string :imei

      t.integer :device_type_id


      t.timestamps
    end


    add_index :mobile_assets, :device_type_id

  end
end
