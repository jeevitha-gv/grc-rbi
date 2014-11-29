class AddTeamIdToControl < ActiveRecord::Migration
  def change
    add_column :controls, :team_id, :integer
  end
end
