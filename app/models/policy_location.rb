class PolicyLocation < ActiveRecord::Base
	belongs_to :policy
	belongs_to :location
end
