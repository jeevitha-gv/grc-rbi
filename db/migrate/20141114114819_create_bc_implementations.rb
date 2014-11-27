class CreateBcImplementations < ActiveRecord::Migration
  def change
    create_table :bc_implementations do |t|
      t.integer :bc_analysis_id
      t.integer :implementation_status_id
      t.text :impl_actions

      t.timestamps
    end
  end
end
