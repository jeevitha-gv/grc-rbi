class SolutionType < ActiveRecord::Base

	has_one :resolution

	validates :name, presence:true, length: { in: 0..50 }
	validates :name, uniqueness:true
end
