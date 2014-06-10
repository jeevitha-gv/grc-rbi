json.data do |json|

	json.array!(@audits) do |audit|
	    json.id audit.id
		json.title audit.title
		json.compliance_type audit.compliance_type
		json.client audit.client_name
		json.audit_type audit.audit_type_name
        json.auditor audit.auditory_full_name
	end
end