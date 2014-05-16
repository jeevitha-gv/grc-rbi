class CreatePrevileges < ActiveRecord::Migration
  def change
    create_table :previleges do |t|
      t.integer :user_id
      t.integer :role_id
      t.integer :method_id
      t.timestamps
    end
  end
end
