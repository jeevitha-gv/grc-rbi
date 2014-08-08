class CreateEvaluates < ActiveRecord::Migration
  def change
    create_table :evaluates do |t|
    	t.integer :incident_id
    	t.integer :urgency_id
    	t.integer :incident_priority_id
    	t.integer :incident_impact_id
    	t.integer :assignee
    	t.date :target_date
    	t.integer :sla_id
    	t.integer :incident_origin_id
    	t.time :resolutiontime
    	t.integer :escalation_id
        
      t.timestamps
    end
  end
end
