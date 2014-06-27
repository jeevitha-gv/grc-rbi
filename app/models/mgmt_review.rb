class MgmtReview < ActiveRecord::Base

	# Associations
	belongs_to :risk
	belongs_to :review
	belongs_to :reviewer, class_name: "User", foreign_key: :reviewer
	belongs_to :next_step


end
