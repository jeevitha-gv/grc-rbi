class CreateIncidents < ActiveRecord::Migration
  def change
    create_table :incidents do |t|
    	t.string :Jobtitle
    	t.string :title
    	t.integer :request_type_id
    	t.integer :incident_category_id
    	t.integer :sub_category_id
    	t.datetime :date_occured
    	t.text :summary
    	t.integer :department_id
    	t.integer :team_id
    	t.integer :incident_status_id
    	t.text :comment
    	t.integer :contact_no
        t.integer :resolution_id
    	 	

      t.timestamps
    end
    add_index :incidents, :request_type_id
    add_index :incidents, :incident_category_id
    add_index :incidents, :sub_category_id
    add_index :incidents, :department_id
    add_index :incidents, :team_id
    add_index :incidents, :incident_status_id
    add_index :incidents, :resolution_id
  end
end
