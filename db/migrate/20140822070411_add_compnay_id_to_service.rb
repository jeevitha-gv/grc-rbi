class AddCompnayIdToService < ActiveRecord::Migration
  def change
  	add_column :services, :company_id, :integer
    add_index  :services, :company_id
  end
end
