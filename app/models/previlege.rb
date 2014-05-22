class Previlege < ActiveRecord::Base
	
	# Rails Association
	belongs_to :role
	belongs_to :user
	belongs_to :modular
end
