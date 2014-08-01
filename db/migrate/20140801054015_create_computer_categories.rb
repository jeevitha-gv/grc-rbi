class CreateComputerCategories < ActiveRecord::Migration
  def change
    create_table :computer_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
