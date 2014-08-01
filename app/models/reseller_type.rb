class ResellerType < ActiveRecord::Base

	  # Assosciations with Asset Module
	  has_many :vendors

end
