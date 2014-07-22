class AddCompanyIdToDepartment < ActiveRecord::Migration
  def change
    add_column :departments, :company_id, :integer
  end
end
