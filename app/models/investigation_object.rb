class InvestigationObject < ActiveRecord::Base
	has_many :frauds
end
