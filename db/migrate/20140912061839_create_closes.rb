class CreateCloses < ActiveRecord::Migration
  def change
    create_table :closes do |t|
    	t.integer :incident_id
    	t.integer :evaluate_id
    	t.integer :resolution_id
    	t.integer :incident_category_id
    	t.integer :department_id
    	t.text :closing_comment

      t.timestamps
    end
  end
end
