class AuditCompliancesController < ApplicationController

	def compliance_checklist
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

<<<<<<< HEAD
  def create
    compliance_params.each do |k, v|
      audit_compliance = AuditCompliance.create(compliance_library_id: v["compliance_library_id"], audit_id: params[:audit_id])
      if(v["artifact_id"].present?)
        v["artifact_id"].each do |artifact_id|
          artifact_answer = audit_compliance.artifact_answers.new(v.reject{|x| x=="artifact_id" || x=="compliance_library_id"})
          artifact_answer.artifact_id = artifact_id
          artifact_answer.save
        end
      else
        audit_compliance.is_answered = true
        audit_compliance.save
      end
    end
  end
  
  
  
    private
    def compliance_params
      params.require(:checklist)
    end
end
=======
    def edit
  end
 end
>>>>>>> 9d20476608ca4a47773aadb3352f1ac03c8d75ad
