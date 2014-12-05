class PolicyReview < ActiveRecord::Base

	# Paper trail
	has_paper_trail

	# Associations
	belongs_to :policy
	belongs_to :review_action
	belongs_to :reviewer, class_name: "PolicyReviewer", foreign_key: :reviewer_id
	
end
