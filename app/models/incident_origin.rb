class IncidentOrigin < ActiveRecord::Base
	validates :name, uniqueness: true
end
