class Resolution < ActiveRecord::Base

	belongs_to :incident
	belongs_to :solution_type
	belongs_to :closure_classification
	belongs_to :parentincident, class_name: 'incident', foreign_key: 'incident_id'
	belongs_to :resolution_user, class_name: 'User', foreign_key: 'reassignee'

	# validates :incident_id, presence:true
	# validates :reassignee, presence:true
	# validates :solution_type_id	,presence:true
	# validates :solution, length: { maximum: 250 }, :if => Proc.new{|f| !f.summary.blank? }
	# validates :root_cause, length: { maximum: 250 }, :if => Proc.new{|f| !f.summary.blank? }
	# validates :closure_classification_id ,presence:true
	# validates :parent_incident,presence:true
	# validates :attachment_id, presence:true


	delegate :name, :to => :closure_classification, prefix: true, allow_nil: true
	delegate :name, :to => :solution_type, prefix: true, allow_nil: true





end
