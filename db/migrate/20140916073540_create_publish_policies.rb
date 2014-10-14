class CreatePublishPolicies < ActiveRecord::Migration
  def change
    create_table :publish_policies do |t|
      t.integer  :policy_id
      t.string	 :distribution_list_ids, array: true, default: []
      t.string	 :subject
      t.text	 :body
      t.timestamps
    end

    add_index :publish_policies, :policy_id
    add_index :publish_policies, :distribution_list_ids
  end
end
