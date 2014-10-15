class IncidentPriority < ActiveRecord::Base

	has_many :evaluates
	# has_many :escalations

	validates :name, presence:true, length: { in: 0..50 }
	validates :name, uniqueness:true
end
