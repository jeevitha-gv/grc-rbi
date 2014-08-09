class IncidentPriority < ActiveRecord::Base
	validates :name, uniqueness: true
end
