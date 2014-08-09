class IncidentImpact < ActiveRecord::Base
	validates :name, uniqueness: true
end
