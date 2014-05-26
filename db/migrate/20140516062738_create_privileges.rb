class CreatePrivileges < ActiveRecord::Migration
  def change
    create_table :privileges do |t|
      t.integer :role_id
      t.integer :modular_id
      t.timestamps
    end
  end
end
