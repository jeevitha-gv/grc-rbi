class CreateClosings < ActiveRecord::Migration
  def change
    create_table :closings do |t|
      t.text :name

      t.timestamps
    end
  end
end
