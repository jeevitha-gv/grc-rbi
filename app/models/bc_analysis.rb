class BcAnalysis < ActiveRecord::Base

	belongs_to :department 
	belongs_to :bu_process
	belongs_to :threat
	belongs_to :vulnerability
	belongs_to :company
	belongs_to :bc_confi, class_name: 'Priority', foreign_key: 'confidentiality'
	belongs_to :bc_avail, class_name: 'Priority', foreign_key: 'availability'
	belongs_to :bc_integ, class_name: 'Priority', foreign_key: 'integrity'
	belongs_to :bc_owner, class_name: 'User', foreign_key: 'owner'
	belongs_to :bc_manager, class_name: 'User', foreign_key: 'manager'

	has_one :bc_plan

end
