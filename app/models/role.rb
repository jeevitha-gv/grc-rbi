class Role < ActiveRecord::Base
		
	has_many :previleges
	has_many :roles
	belongs_to :company
end
