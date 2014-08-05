class CreateUrgencies < ActiveRecord::Migration
  def change
    create_table :urgencies do |t|
      t.string :name

      t.timestamps
    end
  end
end
