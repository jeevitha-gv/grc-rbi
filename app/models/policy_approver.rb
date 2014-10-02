class PolicyApprover < ActiveRecord::Base

	# Associations
	belongs_to :policy
	belongs_to :policy_approver, class_name: "User", foreign_key: 'approver'
	has_one :policy_approval
end
