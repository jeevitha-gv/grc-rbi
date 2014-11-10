class PolicyReview < ActiveRecord::Base

	# Associations
	belongs_to :policy
	belongs_to :review_action
	belongs_to :reviewer, class_name: "PolicyReviewer", foreign_key: :reviewer_id
	has_one :comment , as: :commentable, class_name: "Comment"
	accepts_nested_attributes_for :comment, :allow_destroy => true
end
