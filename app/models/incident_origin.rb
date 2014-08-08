class IncidentOrigin < ActiveRecord::Base

	has_many :evaluates
	validates :name, presence:true, length: { in: 0..50 }
	validates :name, uniqueness:true
end
