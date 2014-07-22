class AddCompanyIdToDepartment < ActiveRecord::Migration
  def change
    add_column :departments, :company_id, :integer
    add_index  :departments, :company_id
  end
end
