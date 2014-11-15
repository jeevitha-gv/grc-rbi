class Investigation < ActiveRecord::Base
	has_one :fraud
	has_one :closing
	has_one :finding
	has_one :rating
	
end
