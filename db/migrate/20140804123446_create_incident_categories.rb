class CreateIncidentCategories < ActiveRecord::Migration
  def change
    create_table :incident_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
