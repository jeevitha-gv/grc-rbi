class PolicyHandler < ActiveRecord::Base

	# Associations
	belongs_to :policy
	belongs_to :policy_reviewer, class_name: "User", foreign_key: :handler
	belongs_to :policy_approver, class_name: "User", foreign_key: :handler
	has_one :policy_approval
	has_one :policy_review
end
