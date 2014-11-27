class CreateBcAcceptances < ActiveRecord::Migration
  def change
    create_table :bc_acceptances do |t|
      t.integer :bc_analysis_id
      t.integer :test_type_id
      t.text :scope
      t.text :test_goal
      t.text :test_objective

      t.timestamps
    end
  end
end
