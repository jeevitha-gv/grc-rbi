class Contract < ActiveRecord::Base

	#Associations
	belongs_to :company
	belongs_to :location
	belongs_to :department
	belongs_to :contract_type
	belongs_to :contract_status

	 has_many :maintenance, class_name: 'OtherAsset', foreign_key: 'maintenance_contract'
	 has_many :lease, class_name: 'OtherAsset', foreign_key: 'lease_contract'
end
