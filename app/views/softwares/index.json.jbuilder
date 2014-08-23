json.data do |json|
  json.array!(@softwares) do |s|
      json.id s.id
      json.product_name s.product_name 
      json.software_type s.software_type.name if s.software_type.present?
      json.location s.location.name
      json.department s.department.name
      
     end
end