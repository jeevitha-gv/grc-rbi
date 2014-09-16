class CreatePolicyReviews < ActiveRecord::Migration
  def change
    create_table :policy_reviews do |t|

      t.integer :policy_id
      t.integer :review_action_id
      t.integer :reviewer_id
      t.timestamps
    end

    add_index :policy_reviews, :policy_id
    add_index :policy_reviews, :review_action_id
    add_index :policy_reviews, :reviewer_id
  end
end
