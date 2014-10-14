class CreatePolicyReviewers < ActiveRecord::Migration
  def change
    create_table :policy_reviewers do |t|
      t.integer :policy_id
      t.integer :user_id

      t.timestamps
    end

    add_index :policy_reviewers, :user_id
    add_index :policy_reviewers, :policy_id
  end
end
