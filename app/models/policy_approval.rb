class PolicyApproval < ActiveRecord::Base

	# Associations
	belongs_to :policy
	belongs_to :approver, class_name: "PolicyApprover", foreign_key: :approver
end
