class ComputerCategory < ActiveRecord::Base


	# Associations with Asset Module
	has_many :computers
end
