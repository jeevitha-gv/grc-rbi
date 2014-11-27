class AddBcStatusIdToBcAnalysis < ActiveRecord::Migration
  def change
    add_column :bc_analyses, :bc_status_id, :integer
  end
end
