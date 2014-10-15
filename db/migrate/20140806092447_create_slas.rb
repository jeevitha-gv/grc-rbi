class CreateSlas < ActiveRecord::Migration
  def change
    create_table :slas do |t|
      t.string :name
      t.text :description
      t.integer :days
      t.integer :hours
      t.integer :minutes
      t.string :holidays

      t.timestamps
    end
  end
end
