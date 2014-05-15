class CreateModulars < ActiveRecord::Migration
  def change
    create_table :modulars do |t|
      t.string :controller_name
      t.string :action_name
      t.integer :section_id

      t.timestamps
    end
  end
end