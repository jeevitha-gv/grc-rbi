class CreateMitigations < ActiveRecord::Migration
  def change
    create_table :mitigations do |t|
      t.integer :risk_id
      t.integer :planning_strategy_id
      t.integer :mitigation_effort_id
      t.text :current_solution
      t.text :security_requirements
      t.text :security_recommendations
      t.integer :submitted_by

      t.timestamps
    end
  end
end
