class MgmtReview < ActiveRecord::Base

	# Associations
	belongs_to :risk
	belongs_to :review
	belongs_to :reviewer, class_name: "User", foreign_key: :reviewer
	belongs_to :next_step
	has_one :comment , as: :commentable, class_name: "Comment"
	accepts_nested_attributes_for :comment, :allow_destroy => true
end