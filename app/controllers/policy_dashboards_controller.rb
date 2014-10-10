class PolicyDashboardsController < ApplicationController
	before_filter :check_company_disabled, :company_module_access_check
	before_filter :company_module_access_check

	layout 'policy_layout'

	def calender
		@policies = current_company.policies
	end

	def index
		
  	end
end
