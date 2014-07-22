class RemoveLocationIdFromDepartment < ActiveRecord::Migration
  def change
    remove_column :departments, :location_id, :integer
  end
end
