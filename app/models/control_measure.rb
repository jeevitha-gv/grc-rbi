class ControlMeasure < ActiveRecord::Base

	# Associations
	belongs_to :risk
	belongs_to :risk_scoring
end
