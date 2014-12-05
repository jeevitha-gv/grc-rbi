class AddControlStatusIdToControl < ActiveRecord::Migration
  def change
    add_column :controls, :control_status_id, :integer
  end
end
