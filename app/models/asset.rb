class Asset < ActiveRecord::Base
	belongs_to :assetable, :polymorphic => true
	has_one :assessment
end
