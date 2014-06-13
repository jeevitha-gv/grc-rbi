json.data do |json|
	json.array!(@audit_compliances) do |compliance|
    if(compliance.artifact_answers.present?)
      compliance.artifact_answers.each do |artifact_answer|
        json.id compliance.id
        json.name compliance.compliance_library_name
        json.artifact_id artifact_answer.artifact_id
        json.artifact_name artifact_answer.artifact_name
        json.artifact_answer_id artifact_answer.id
        json.priority artifact_answer.priority_name
        json.auditee artifact_answer.responsibility_full_name
        json.target_date artifact_answer.target_date
      end   
    end
	end
end