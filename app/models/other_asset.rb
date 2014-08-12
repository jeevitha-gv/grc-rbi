class OtherAsset < ActiveRecord::Base


	# Associations
	belongs_to :company
	belongs_to :asset_status
	belongs_to :asset_type
	belongs_to :otherasset_owner, class_name: 'User', foreign_key: 'asset_owner'
	belongs_to :otherasset_user, class_name: 'User', foreign_key: 'asset_user'
	belongs_to :location
	belongs_to :department
	belongs_to :maintenance, class_name: 'Contract', foreign_key: 'maintenance_contract'
	belongs_to :lease, class_name: 'Contract', foreign_key: 'lease_contract'
	has_many :lifecycles

	# Validations
	validates_presence_of :name
	validates_presence_of :manufacturer
	validates_presence_of :asset_type_id
	validates_presence_of :asset_status_id


end