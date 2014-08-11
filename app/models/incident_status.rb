class IncidentStatus < ActiveRecord::Base

	belongs_to :incident

	validates :name, presence:true, length: { in: 0..50 }
	validates :name, uniqueness:true

end
