class PolicyReviewer < ActiveRecord::Base

	# Associations
	belongs_to :policy
	belongs_to :policy_reviewer, class_name: "User", foreign_key: 'reviewer'
	has_one :policy_review
end
