class Risk < ActiveRecord::Base

	# Associations
	has_many :mgmt_review
	has_many :closure
	has_many :control_measures
	
end
