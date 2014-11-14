class CreateBcPlans < ActiveRecord::Migration
  def change
    create_table :bc_plans do |t|
      t.integer :bc_analysis_id
      t.string :plan
      t.string :opex
      t.string :capex
      t.integer :plan_responsible
      t.integer :launch_responsible
      t.integer :bcm_status_id
      t.integer :recurrence_id
      t.date :review_date
      t.text :objective
      t.text :audit_metric
      t.text :success_criteria
      t.text :launch_criteria

      t.timestamps
    end
  end
end
