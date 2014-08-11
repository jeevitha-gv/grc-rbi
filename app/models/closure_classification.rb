class ClosureClassification < ActiveRecord::Base
	has_many :resolutions

	validates :name, presence:true, length: { in: 0..50 }
	validates :name, uniqueness:true
	
end
