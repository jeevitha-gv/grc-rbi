class Risk < ActiveRecord::Base

	# Associations
	has_many :mgmt_review
	has_many :closure
	has_many :control_measures
	belongs_to :risk_status
	belongs_to :compliance
	belongs_to :location
	belongs_to :category #Need Clarity
	belongs_to :team
end
