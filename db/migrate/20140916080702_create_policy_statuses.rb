class CreatePolicyStatuses < ActiveRecord::Migration
  def change
    create_table :policy_statuses do |t|
      t.string :name
      t.timestamps
    end
  end
end
