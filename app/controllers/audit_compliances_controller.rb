class AuditCompliancesController < ApplicationController
    before_filter :check_for_current_audit
    before_filter :authorize_auditees_skip_company_admin, :only => [:response, :response_checklist]
    before_filter :authorize_auditees, :only => [:submit]
    before_filter :check_for_auditee_response, only: [:index]
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
    audit.build_audit_compliance(compliance_params) unless(audit.audit_status_id == 4)
  end

  def submit
    current_audit.audit_compliances.update_all(is_answered: true)  unless(current_audit.audit_status_id == 4)
    redirect_to audits_path
  end

  private
  def compliance_params
    params.require(:checklist)
  end

  def check_for_auditee_response
    if(current_audit.auditees.map(&:id).include?(current_user.id))
      redirect_to response_audit_compliances_path
    end
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
            json["target_date"] = (artifact_answer.target_date.present? ? artifact_answer.target_date.to_date.strftime("%d/%m/%Y") : "")
            response << json
          end   
        end
      end
      response
    end
  
end
