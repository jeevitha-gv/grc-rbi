class CreateControlStates < ActiveRecord::Migration
  def change
    create_table :control_states do |t|
      t.string :name
      t.timestamps
    end
  end
end
