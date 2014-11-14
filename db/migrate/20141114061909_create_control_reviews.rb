class CreateControlReviews < ActiveRecord::Migration
  def change
    create_table :control_reviews do |t|
    	t.integer :control_id
    	t.integer :control_approval_id
    	t.integer :fraud_related_id
    	t.text :execution_steps
    	t.text :expected_result

      t.timestamps
    end
    add_index :control_reviews, :control_id
    add_index :control_reviews, :control_approval_id
    add_index :control_reviews, :fraud_related_id
  end
end
