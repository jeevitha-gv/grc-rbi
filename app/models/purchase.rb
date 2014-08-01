class Purchase < ActiveRecord::Base

	#Associations
	belongs_to :other_asset
	belongs_to :vendor
end
