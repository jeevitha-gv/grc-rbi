class CreateSubCategories < ActiveRecord::Migration
  def change
    create_table :sub_categories do |t|
      t.integer :incident_category_id
      t.string :name

      t.timestamps
    end
    add_index :sub_categories, :incident_category_id

  end
end
