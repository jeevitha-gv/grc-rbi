class AuditCompliancesController < ApplicationController

	def compliance_checklist
		@compliance_libraries = ComplianceLibrary.where(:is_leaf => true)
		@priorities = Priority.all
		@auditees = current_company.users.all
	end

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
