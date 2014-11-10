class PolicyApproval < ActiveRecord::Base

	# Associations
	belongs_to :policy
	belongs_to :policy_approver, class_name: "PolicyApprover", foreign_key: :approver
	has_one :comment , as: :commentable, class_name: "Comment"
	accepts_nested_attributes_for :comment, :allow_destroy => true
end
