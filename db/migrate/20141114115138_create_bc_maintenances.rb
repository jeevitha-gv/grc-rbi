class CreateBcMaintenances < ActiveRecord::Migration
  def change
    create_table :bc_maintenances do |t|
      t.integer :bc_analysis_id
      t.integer :recurrence_id
      t.text :issues
      t.boolean :decision

      t.timestamps
    end
  end
end
