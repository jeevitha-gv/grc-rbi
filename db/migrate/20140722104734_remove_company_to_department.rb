class RemoveCompanyToDepartment < ActiveRecord::Migration
  def change
    remove_column :departments, :company, :integer
  end
end
