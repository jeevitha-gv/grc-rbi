class AuditCompliancesController < ApplicationController

	def index
		@compliance_libraries = ComplianceLibrary.where(:is_leaf => true)
		@priorities = Priority.all
		@auditees = current_company.users.all
		if params[:audit_id].present?
			@audit = Audit.find(params[:audit_id])
			redirect_to new_audit_compliance_path if @audit.audit_compliances.blank?
		end
    end
    
    def new
    end

    def edit
  end
 end
