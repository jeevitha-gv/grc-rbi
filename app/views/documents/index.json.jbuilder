json.data do |json|
  json.array!(@documents) do |d|
      json.id d.id
      json.document_status d.document_status.name if d.document_status.present?
      json.document_type d.document_type.name if d.document_type.present?
      json.location d.location.name
      json.department d.department.name
      
     end
end