class PolicyApproval < ActiveRecord::Base

	# Associations
	belongs_to :policy
	belongs_to :approver, class_name: "PolicyHandler", foreign_key: :reviewer_id
end
