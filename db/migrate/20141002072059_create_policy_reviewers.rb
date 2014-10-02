class CreatePolicyReviewers < ActiveRecord::Migration
  def change
    create_table :policy_reviewers do |t|
      t.integer :policy_id
      t.integer :reviewer

      t.timestamps
    end

    add_index :policy_handlers, :reviewer
    add_index :policy_handlers, :policy_id
  end
end
