json.data do |json|
  json.array!(@contracts) do |c|  	  
  	  json.id c.id
      json.contract_type c.contract_type.name
      json.contract_status c.contract_status.name
      json.name c.name
      json.location c.location.name
      end
end