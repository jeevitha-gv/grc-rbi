class CreatePolicyApprovals < ActiveRecord::Migration
  def change
    create_table :policy_approvals do |t|
      t.integer :policy_id
      t.integer :approval_action_id
      t.integer :approver
      t.date 	:remind_me
      t.timestamps
    end

     add_index :policy_approvals, :policy_id
     add_index :policy_approvals, :approval_action_id
     add_index :policy_approvals, :approver
  end
end
