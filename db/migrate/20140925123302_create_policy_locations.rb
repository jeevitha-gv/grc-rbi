class CreatePolicyLocations < ActiveRecord::Migration
  def change
    create_table :policy_locations do |t|
      t.integer :policy_id
      t.integer :location_id

      t.timestamps
    end

    add_index :policy_locations, :policy_id
    add_index :policy_locations, :location_id
    
  end
end
