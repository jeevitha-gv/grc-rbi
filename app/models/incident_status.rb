class IncidentStatus < ActiveRecord::Base

	has_many :incidents
	scope :for_name, lambda {|name| where("name = (?)", name)}
	
	validates :name, presence:true, length: { in: 0..50 }
	validates :name, uniqueness:true

end
