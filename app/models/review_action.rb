class ReviewAction < ActiveRecord::Base

	# Association
	has_many :policy_reviews

end
