class InformationAsset < ActiveRecord::Base
	has_one :asset , as: :assetable
	belongs_to :company
	

	accepts_nested_attributes_for :asset
end
