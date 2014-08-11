class SubCategory < ActiveRecord::Base

	has_many :incidents

	validates :name, presence:true, length: { in: 0..50 }
	validates :name, uniqueness:true
	validates :incident_category_id, presence:true
end
