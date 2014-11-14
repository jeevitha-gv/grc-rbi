class CreatePublishDistributionLists < ActiveRecord::Migration
  def change
    create_table :publish_distribution_lists do |t|
      t.integer :publish_policy_id
      t.integer :distribution_list_id
      t.timestamps
    end
    add_index :publish_distribution_lists, :publish_policy_id
    add_index :publish_distribution_lists, :distribution_list_id
  end
end
