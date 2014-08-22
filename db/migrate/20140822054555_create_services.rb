class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name
      t.integer :service_type_id
      t.text :description
      t.string :cost
      t.string :sla
      t.integer :location_id
      t.integer :department_id
      t.integer :asset_manager_id
      t.integer :asset_user_id
      t.datetime :assigned_on

      t.timestamps
    end
    add_index :services, :service_type_id
    add_index :services, :location_id
    add_index :services, :department_id
    add_index :services, :asset_manager_id
    add_index :services, :asset_user_id
  end
end
