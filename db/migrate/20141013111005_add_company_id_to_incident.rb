class AddCompanyIdToIncident < ActiveRecord::Migration
  def change
    add_column :incidents, :company_id, :integer
  end
end
