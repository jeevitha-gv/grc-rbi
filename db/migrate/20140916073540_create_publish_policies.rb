class CreatePublishPolicies < ActiveRecord::Migration
  def change
    create_table :publish_policies do |t|
      t.integer  :policy_id
      t.string	 :subject
      t.text	 :body
      t.timestamps
    end

    add_index :publish_policies, :policy_id
  end
end
