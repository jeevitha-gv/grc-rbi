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
    	 	

      t.timestamps
    end
  end
end
