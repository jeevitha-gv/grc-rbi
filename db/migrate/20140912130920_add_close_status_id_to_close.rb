class AddCloseStatusIdToClose < ActiveRecord::Migration
  def change
    add_column :closes, :close_status_id, :integer
  end
end
