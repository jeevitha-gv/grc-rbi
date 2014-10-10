class PolicyLocation < ActiveRecord::Base
	
	# Association
	belongs_to :policy
	belongs_to :location

end
