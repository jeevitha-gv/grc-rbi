class AuditCompliancesController < ApplicationController

	def compliance_checklist
    @audit = Audit.find(params[:audit_id])
    @auditees = @audit.auditees
    @audit_compliances = @audit.audit_compliances
		@compliance_libraries = ComplianceLibrary.where(:is_leaf => true)
		@priorities = Priority.all
  end 

  def response_checklist
    @audit = Audit.find(params[:audit_id])
    @audit_compliances = @audit.audit_compliances
  end

  def create
    audit = Audit.find(params[:audit_id])
    old_compliance = audit.audit_compliances.map(&:id)
    compliance_params.each do |k, v|
      audit_compliance = AuditCompliance.find_or_create_by(compliance_library_id: v["compliance_library_id"], audit_id: params[:audit_id])
      old_compliance.delete(audit_compliance.id)
      old_artifact_answers = audit_compliance.artifact_answers.map(&:id)
      if(v["artifact_id"].present?)
         artifact_ids =  v["artifact_id"].class == Array ? v["artifact_id"] : v["artifact_id"].split(",")
        artifact_ids.each do |artifact_id|
          artifact_answer = ArtifactAnswer.find_or_create_by(artifact_id: artifact_id.to_i,audit_compliance_id: audit_compliance.id)
          old_artifact_answers.delete(artifact_answer.id)
          artifact_answer.update(v.reject{|x| x=="artifact_id" || x=="compliance_library_id" || x=="artifact_answers"})
        end
      else
        if(v["artifact_answers"].present?)
          artifact_answer = ArtifactAnswer.find(v["artifact_answers"].to_i) rescue ""
          if(artifact_answer.present? && !artifact_answer.artifact_id.present?)
            old_artifact_answers.delete(artifact_answer.id)
            artifact_answer.update(v.reject{|x| x=="artifact_id" || x=="compliance_library_id" || x == "artifact_answers"})
          end
        else
          artifact_answer = audit_compliance.artifact_answers.create(v.reject{|x| x=="artifact_id" || x=="compliance_library_id" || x == "artifact_answers"})
        end
      end      
      ArtifactAnswer.delete(old_artifact_answers) if old_artifact_answers.present?
    end
    AuditCompliance.delete(old_compliance) if old_compliance.present?
  end

  def submit
    audit = Audit.find(params[:audit_id])
    audit.audit_compliances.update_all(is_answered: true)
    redirect_to "/"
  end

    private
    def compliance_params
      params.require(:checklist)
    end
end
