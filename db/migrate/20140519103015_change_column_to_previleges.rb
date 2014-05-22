class ChangeColumnToPrevileges < ActiveRecord::Migration
  def change
rename_column :previleges, :method_id, :modular_id
  end
end
