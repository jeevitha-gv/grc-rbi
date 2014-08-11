class Contract < ActiveRecord::Base

	#Associations
	belongs_to :company
	belongs_to :location
	belongs_to :department
	belongs_to :contract_type
	belongs_to :contract_status

	 has_many :maintenance, class_name: 'OtherAsset', foreign_key: 'maintenance_contract'
	 has_many :lease, class_name: 'OtherAsset', foreign_key: 'lease_contract'


	scope :contract_name, ->(id) { where(id: id).first.name}
	scope :for_name_by_company, lambda {|contract_name,company_id,contract_type_id| where("lower(name)=? and company_id=? and contract_type_id=?", contract_name,company_id,contract_type_id) }
end
