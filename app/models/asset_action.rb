class AssetAction < ActiveRecord::Base
	belongs_to :asset
	has_many :attachments, as: :attachable
	accepts_nested_attributes_for :attachments, reject_if: lambda { |a| a[:attachment_file].blank? }
end
