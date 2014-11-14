class CreateControls < ActiveRecord::Migration
  def change
    create_table :controls do |t|

    	t.integer :controlid
    	t.string :name
    	t.integer :owner
    	t.integer :owner_delegate
    	t.text :objective
    	t.text :maintenance_metric_description
    	t.text :maintenance_metric_description
    	t.text :note
    	t.integer :classification_control_id
    	t.integer :purpose_control_id
    	t.integer :owning_group_id
    	t.integer :control_regulation_id

      t.timestamps
    end
    add_index :controls, :owner
    add_index :controls, :owner_delegate
    add_index :controls, :classification_control_id
    add_index :controls, :purpose_control_id
    add_index :controls, :owning_group_id
    add_index :controls, :control_regulation_id
  end
end
