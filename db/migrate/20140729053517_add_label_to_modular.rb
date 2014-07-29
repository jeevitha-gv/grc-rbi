class AddLabelToModular < ActiveRecord::Migration
  def change
    add_column :modulars, :label, :string
  end
end
