class PolicyApproval < ActiveRecord::Base

	# Associations
	belongs_to :policy
<<<<<<< HEAD
	belongs_to :policy_approver, class_name: "PolicyApprover", foreign_key: :approver
	has_one :comment , as: :commentable, class_name: "Comment"
	accepts_nested_attributes_for :comment, :allow_destroy => true
=======
	belongs_to :approval_action
	belongs_to :approver, class_name: "PolicyApprover", foreign_key: :approver
>>>>>>> c7b2ce89a6104386a42c58add48818d651e901f0
end
