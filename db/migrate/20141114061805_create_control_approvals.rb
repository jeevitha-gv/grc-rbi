class CreateControlApprovals < ActiveRecord::Migration
  def change
    create_table :control_approvals do |t|
    	t.integer :control_id
    	t.text :comments

      t.timestamps
    end
    add_index :control_approvals, :control_id
  end
end
