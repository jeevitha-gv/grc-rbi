class CreatePolicyHandlers < ActiveRecord::Migration
  def change
    create_table :policy_handlers do |t|
      t.integer :handler
      t.integer :policy_id
      t.string	:type
      t.timestamps
    end

    add_index :policy_handlers, :handler
    add_index :policy_handlers, :policy_id

  end
end
