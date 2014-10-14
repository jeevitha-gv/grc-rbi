class CreatePolicyKinds < ActiveRecord::Migration
  def change
    create_table :policy_kinds do |t|
      t.string :name
      t.timestamps
    end
  end
end
