class Evaluate < ActiveRecord::Base

    belongs_to :incident
	belongs_to :urgency
	belongs_to :incident_priority
	belongs_to :incident_impact
	belongs_to :evaluate_assignee, class_name: 'User', foreign_key: 'assignee'
	belongs_to :sla
	belongs_to :incident_origin
	belongs_to :escalation
	

	delegate :name, :to => :incident_impact, prefix: true, allow_nil: true
	delegate :name, :to => :urgency, prefix: true, allow_nil: true
	delegate :name, :to => :incident_priority, prefix: true, allow_nil: true
	delegate :name, :to => :sla, prefix: true, allow_nil: true
	delegate :name, :to => :incident_origin, prefix: true, allow_nil: true
	delegate :name, :to => :escalation, prefix: true, allow_nil: true
	delegate :level, :to => :incident_category, prefix: true, allow_nil: true



	# validates :incident_id, presence:true
	# validates :urgency_id, presence:true
	# validates :incident_priority_id, presence:true
	# validates :incident_impact_id, presence:true
	# validates :assignee, presence:true
	# validates :target_date, presence:true
	# validates :sla_id, presence:true
	# validates :incident_origin_id, presence:true
	# validates :resolutiontime, presence:true
	# validates :escalation_id, presence:true
end
