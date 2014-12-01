class CreateOwningGroups < ActiveRecord::Migration
  def change
    create_table :owning_groups do |t|
      t.string :name

      t.timestamps
    end
  end
end
