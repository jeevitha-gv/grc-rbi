class AuditCompliancesController < ApplicationController

	def compliance_checklist
    @audit = Audit.find(params[:audit_id])
		@compliance_libraries = ComplianceLibrary.where(:is_leaf => true)
		@priorities = Priority.all
<<<<<<< HEAD
=======
		@auditees = current_company.users.all
		if params[:audit_id].present?
			@audit = Audit.find(params[:audit_id])
			redirect_to new_audit_compliance_path if @audit.audit_compliances.blank?
		end
  end

  def new
>>>>>>> 03d5d3acb95d4d7951d9a8aeacdb2fb1af51da36
  end

  def edit
<<<<<<< HEAD
    @audit = Audit.find(params[:audit_id])
    @audit_compliances = @audit.audit_compliances
  end  
 
=======

  end

  # def response
  # end


>>>>>>> 03d5d3acb95d4d7951d9a8aeacdb2fb1af51da36
  def response_checklist
    @audit = Audit.find(params[:audit_id])
    @audit_compliances = @audit.audit_compliances
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
        artifact_answer = audit_compliance.artifact_answers.create(v.reject{|x| x=="artifact_id" || x=="compliance_library_id"})
      end
    end
  end
<<<<<<< HEAD
  
  def submit
    audit = Audit.find(params[:audit_id])
    audit.audit_compliances.update_all(is_answered: true)
    redirect_to "/"
  end
  
=======

>>>>>>> 03d5d3acb95d4d7951d9a8aeacdb2fb1af51da36
    private
    def compliance_params
      params.require(:checklist)
    end
end
