class CreatePolicies < ActiveRecord::Migration
  def change
    create_table :policies do |t|
      t.integer :company_id
      t.string  :policy_unique_id
      t.string  :title
      t.integer :policy_kind_id
      t.integer :audience_id
      t.integer :policy_classification_id
      t.string	:loctaion_ids, array: true, default: []
      t.string	:departments_ids, array: true, default: []
      t.text	:scope
      t.text	:purpose
      t.text	:description
      t.text	:note
      t.integer	:standard_id
      t.string	:control_ids, array: true, default: []
      t.integer :owner
      t.date	:effective_from
      t.date	:effective_till
      t.date	:expected_publish_date
      t.date 	:review_within_date
      t.integer	:policy_status_id
      t.timestamps
    end

    add_index :policies, :company_id
    add_index :policies, :policy_kind_id
    add_index :policies, :audience_id
    add_index :policies, :policy_classification_id
    add_index :policies, :loctaion_ids
    add_index :policies, :departments_ids
    add_index :policies, :standard_id
    add_index :policies, :control_ids
    add_index :policies, :owner
    add_index :policies, :effective_till
    add_index :policies, :effective_from
    add_index :policies, :expected_publish_date
    add_index :policies, :review_within_date
    add_index :policies, :policy_status_id
  end
end
