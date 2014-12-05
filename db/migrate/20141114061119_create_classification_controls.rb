class CreateClassificationControls < ActiveRecord::Migration
  def change
    create_table :classification_controls do |t|
      t.string :name

      t.timestamps
    end
  end
end
