module ChecklistRecommendationsHelper

	def audit_checklist(control, audit_id)
		@audit_compliance = AuditCompliance.where('compliance_library_id= ? AND audit_id= ?',control.id, audit_id)
		checklist = @audit_compliance.collect {|x| x.checklist_recommendations} if @audit_compliance
	end

	def checklist_control(checklist)
		checklist.checklist.compliance_library
	end
	
end
