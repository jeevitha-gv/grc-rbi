class BcPlan < ActiveRecord::Base

	belongs_to :bc_analysis
	belongs_to :plan_status
	belongs_to :recurrence
	belongs_to :plan_resp, class_name: 'User', foreign_key: 'plan_responsible'
	belongs_to :launch_resp, class_name: 'User', foreign_key: 'launch_responsible'

end
