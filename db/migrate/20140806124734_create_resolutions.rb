class CreateResolutions < ActiveRecord::Migration
  def change
    create_table :resolutions do |t|

    	t.integer :evaluate_id
    	t.integer :incident_id
    	t.integer :reassignee
    	t.integer :solution_type_id
    	t.text :solution
    	t.text :rootcause
    	t.integer :closure_classification_id
    	

      t.timestamps
    end
    add_index :resolutions, :evaluate_id
    add_index :resolutions, :incident_id
    add_index :resolutions, :reassignee
    add_index :resolutions, :solution_type_id
    add_index :resolutions, :closure_classification_id
  end
end
