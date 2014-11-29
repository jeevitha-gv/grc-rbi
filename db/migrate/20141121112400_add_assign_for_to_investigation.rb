class AddAssignForToInvestigation < ActiveRecord::Migration
  def change
    add_column :investigations, :assign_for, :integer
  end
end
