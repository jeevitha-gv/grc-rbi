class PolicyApprover < ActiveRecord::Base

	# Associations
	belongs_to :policy
	belongs_to :user
	has_one :policy_approval
end
