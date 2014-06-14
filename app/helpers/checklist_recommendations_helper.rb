module ChecklistRecommendationsHelper

	# def audit_checklist(control, audit_id)
	# 	@audit_compliance = AuditCompliance.where('compliance_library_id= ? AND audit_id= ?',control.id, audit_id).first
	# 	@audit_compliance.checklist_recommendations.first if @audit_compliance
	# end

	# def checklist_control(checklist)
	# 	checklist.checklist.compliance_library
	# end
	
	def audit_compliance_id(control_id, audit_id)
	 AuditCompliance.where('compliance_library_id= ? AND audit_id= ?',control_id,audit_id).first.id
	end
end
