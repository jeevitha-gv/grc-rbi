class Closure < ActiveRecord::Base

	# Associations
	belong_to :risk
	belong_to :user
	belong_to :close_reason

end
