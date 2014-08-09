class IncidentStatus < ActiveRecord::Base
	validates :name, uniqueness: true
end
