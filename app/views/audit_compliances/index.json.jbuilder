json.data do |json|

	json.array!(@compliance_libraries) do |compliance|
		json.id compliance.id
		json.name compliance.name
		json.artifacts compliance.artifacts.map(&:name)
		json.priority @priorities.map(&:name)
		json.auditee @auditees.map(&:user_name)
	end
end