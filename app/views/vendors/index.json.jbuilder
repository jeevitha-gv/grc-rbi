json.data do |json|
  json.array!(@vendors) do |v|
      json.id v.id
      json.name v.name
      json.reseller_type v.reseller_type.name
      json.contact_name v.contact_name
      json.contact_email v.contact_email
      json.city v.city
      end
end