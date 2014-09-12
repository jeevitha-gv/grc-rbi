class Asset < ActiveRecord::Base
	belongs_to :assetable, :polymorphic => true
	belongs_to :company
	belongs_to :location
	belongs_to :department
	belongs_to :asset_state
	belongs_to :classification
	belongs_to :info_asset_owner, class_name: 'User', foreign_key: 'owner_id'
	belongs_to :info_asset_custodian, class_name: 'User', foreign_key: 'custodian_id'
	belongs_to :info_asset_identifier, class_name: 'User', foreign_key: 'identifier_id'
	belongs_to :info_asset_evaluator, class_name: 'User', foreign_key: 'evaluated_by'
	belongs_to :asset_confi, class_name: 'Priority', foreign_key: 'confidentiality'
	belongs_to :asset_avail, class_name: 'Priority', foreign_key: 'availability'
	belongs_to :asset_integ, class_name: 'Priority', foreign_key: 'integrity'

	has_one :assessment

	has_one :asset_review

	has_one :asset_action
	belongs_to :users
end
