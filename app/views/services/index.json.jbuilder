json.data do |json|
  json.array!(@services) do |s|
      json.id s.id
      json.name s.name
      json.service_type s.service_type.name if s.service_type.present?
      json.location s.location.name
      json.department s.department.name
      
     end
end