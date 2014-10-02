class CreatePolicyApprovers < ActiveRecord::Migration
  def change
    create_table :policy_approvers do |t|
      t.integer :policy_id
      t.integer :approver

      t.timestamps
    end

    add_index :policy_handlers, :approver
    add_index :policy_handlers, :policy_id
  end
end
