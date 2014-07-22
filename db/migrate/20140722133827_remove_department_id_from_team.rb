class RemoveDepartmentIdFromTeam < ActiveRecord::Migration
  def change
    remove_column :teams, :department_id, :integer
  end
end
