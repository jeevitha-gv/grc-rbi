class Role < ActiveRecord::Base
		
		has_many :previleges
	  belongs_to :company
end
