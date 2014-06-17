class CreateChecklistRecommendations < ActiveRecord::Migration
  def change
    create_table :checklist_recommendations do |t|
      t.integer :checklist_id
      t.string :checklist_type
      t.integer :auditee_id
      t.text :recommendation
      t.text :reason
      t.text :corrective
      t.text :preventive
      t.date :closure_date
      t.integer :recommendation_priority_id
      t.integer :recommendation_severity_id
      t.integer :response_priority_id
      t.integer :response_severity_id
      t.integer :recommendation_status_id
      t.integer :response_status_id
      t.integer :dependent_recommendation
      t.integer :blocking_recommendation
      t.text :observation
      t.boolean :is_implemented, :default => false
      t.boolean :recommendation_completed, :default => false
      t.boolean :response_completed, :default => false


      t.timestamps
    end
  end
end
