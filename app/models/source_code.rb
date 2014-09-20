class SourceCode < ActiveRecord::Base
	has_one :asset, as: :assetable
	accepts_nested_attributes_for :asset
end
