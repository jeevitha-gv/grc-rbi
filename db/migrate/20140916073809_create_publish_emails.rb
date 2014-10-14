class CreatePublishEmails < ActiveRecord::Migration
  def change
    create_table :publish_emails do |t|
      t.string :email
      t.integer :publish_policy_id
      t.timestamps
    end
    add_index :publish_emails, :publish_policy_id
  end
end
