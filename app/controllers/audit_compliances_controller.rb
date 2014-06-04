class AuditCompliancesController < ApplicationController

	def index
		@compliance_libraries = ComplianceLibrary.where(:is_leaf => true)
		@priorities = Priority.all
	end

end
