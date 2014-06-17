class AuditCompliancesController < ApplicationController
    before_filter :check_for_current_audit
    before_filter :authorize_auditees_skip_company_admin, :only => [:response, :response_checklist]
    before_filter :authorize_auditees, :only => [:submit]
    before_filter :authorize_auditor_skip_company_admin, :only => [:index, :compliance_checklist]
    before_filter :authorize_auditor, :only => [:create]

	def compliance_checklist
    @audit = current_audit
    @auditees = @audit.auditees
    @audit_compliances = @audit.audit_compliances
		@compliance_libraries = @audit.default_compliance_libraries
		@priorities = Priority.all
  end 

  def response_checklist
    @audit = current_audit
    @audit_compliances = @audit.audit_compliances_for_current_user(current_user.id)
    render json: {data: build_response}
  end

  def create
    audit = current_audit
    old_compliance = audit.audit_compliances.map(&:id)
    compliance_params.each do |k, v|
      audit_compliance = AuditCompliance.find_or_create_by(compliance_library_id: v["compliance_library_id"], audit_id: audit.id)
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
    audit = current_audit
    audit.audit_compliances.update_all(is_answered: true)
    redirect_to "/"
  end

  private
  def compliance_params
    params.require(:checklist)
  end
  
  def build_response
    response = []
      @audit_compliances.each do |compliance|        
        if(compliance.artifact_answers.present?)
          compliance.artifact_answers.each do |artifact_answer|
            json = {} 
            json["id"] = artifact_answer.id
            json["name"] = compliance.compliance_library_name
            json["artifact_id"] = artifact_answer.artifact_id
            json["artifact_name"] = artifact_answer.artifact_name
            json["audit_compliance"] = compliance.id
            json["priority"] = artifact_answer.priority_name
            json["auditee"] = artifact_answer.responsibility_full_name
            json["target_date"] = artifact_answer.target_date
            response << json
          end   
        end
      end
      response
    end
  
end
