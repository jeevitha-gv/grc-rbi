class Risk < ActiveRecord::Base

	# Associations
	has_one :mgmt_review
	has_many :closures
	has_many :control_measures
	has_many :risk_scorings
	has_one :mitigation
	belongs_to :risk_status
	belongs_to :compliance
	belongs_to :location
	belongs_to :company
	# need clarification for categories
	# belongs_to :category, class_name: 'RiskCategory', foreign_key: 'category_id'
	belongs_to :team
	belongs_to :department
	belongs_to :compliance_library
	belongs_to :technology
	belongs_to :risk_owner, class_name: 'User', foreign_key: 'owner'
	belongs_to :submitor, class_name: 'User', foreign_key: 'submitted_by'
	belongs_to :project
	belongs_to :risk_approval_status, foreign_key: 'risk_approval_status_id'
end