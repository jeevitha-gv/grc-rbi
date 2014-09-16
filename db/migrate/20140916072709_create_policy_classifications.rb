class CreatePolicyClassifications < ActiveRecord::Migration
  def change
    create_table :policy_classifications do |t|
      t.string :name
      t.timestamps
    end
  end
end
