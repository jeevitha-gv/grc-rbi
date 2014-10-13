class AddScoreToPriority < ActiveRecord::Migration
  def change
    add_column :priorities, :score, :integer
  end
end
