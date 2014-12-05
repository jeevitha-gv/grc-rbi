class AddDescriptionToControls < ActiveRecord::Migration
  def change
    add_column :controls, :description, :text
  end
end
