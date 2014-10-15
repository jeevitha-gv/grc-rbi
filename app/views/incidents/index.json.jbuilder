json.data do |json|

	json.array!(@incident) do |incident|
	  json.id incident.id
		json.title incident.title
		json.request_type incident.request_type_name if incident.request_type.present?
		json.incident_category incident.incident_category_name if incident.incident_category.present?
		json.incident_status incident.incident_status_name if incident.incident_status.present?
		json.team incident.team_name
	end
end
