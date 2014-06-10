json.data do |json|

	json.array!(@compliance_libraries) do |compliance|
		json.id compliance.id
		json.name compliance.name
		json.artifacts compliance.artifacts.map{ |f| [f.id,f.name]}
		json.priority @priorities.map{ |f| [f.id,f.name]}
		json.auditee @auditees.map{ |f| [f.id,f.user_name]}
	end
end