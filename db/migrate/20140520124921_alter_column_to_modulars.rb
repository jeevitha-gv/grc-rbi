class AlterColumnToModulars < ActiveRecord::Migration
  def change
  rename_column :modulars, :controller_name, :modal_name
  end
end
