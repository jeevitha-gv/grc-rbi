class PolicyDepartment < ActiveRecord::Base
	belongs_to :policy
	belongs_to :department
end
