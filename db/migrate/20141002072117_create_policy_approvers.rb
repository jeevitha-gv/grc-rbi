class CreatePolicyApprovers < ActiveRecord::Migration
  def change
    create_table :policy_approvers do |t|
      t.integer :policy_id
      t.integer :user_id

      t.timestamps
    end

    add_index :policy_approvers, :user_id
    add_index :policy_approvers, :policy_id
  end
end
