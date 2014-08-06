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
  end
end
