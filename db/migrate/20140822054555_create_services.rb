class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.integer :service_type_id
      t.string :cost
      t.string :sla
      t.date :assigned_on

      t.timestamps
    end
    add_index :services, :service_type_id
    
  end
end
