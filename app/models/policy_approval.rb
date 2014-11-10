class PolicyApproval < ActiveRecord::Base

	# Associations
	belongs_to :policy
	belongs_to :approval_action
	belongs_to :approver, class_name: "PolicyApprover", foreign_key: :approver
end
