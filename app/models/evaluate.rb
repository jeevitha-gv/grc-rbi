class Evaluate < ActiveRecord::Base

	belongs_to :urgency
	belongs_to :incident_priority
	belongs_to :incident_impact
	belongs_to :evaluate_assignee, class_name: 'User', foreign_key: 'assignee'
	belongs_to :sla
	belongs_to :incident_origin
	belongs_to :escalation
	belongs_to :incident

	delegate :name, :to => :incident_impact, prefix: true, allow_nil: true
	
	validates :incident_id, presence:true
	validates :urgency_id, presence:true
	validates :incident_priority_id, presence:true
	validates :incident_impact_id, presence:true
	validates :assignee, presence:true
	validates :target_date, presence:true
	validates :sla_id, presence:true
	validates :incident_origin_id, presence:true
	validates :resolutiontime, presence:true
	validates :escalation_id, presence:true
end
