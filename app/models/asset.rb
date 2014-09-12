class Asset < ActiveRecord::Base
	belongs_to :assetable, :polymorphic => true
	has_one :assessment

	has_one :asset_review

	has_one :asset_action
end
