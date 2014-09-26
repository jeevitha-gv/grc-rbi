class CreatePolicyDepartments < ActiveRecord::Migration
  def change
    create_table :policy_departments do |t|
      t.integer :policy_id
      t.integer :department_id

      t.timestamps
    end
  end
end
