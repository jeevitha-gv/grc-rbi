json.data do |json|
  json.array!(@computers) do |c|  	  
  	  json.id c.id
      json.name c.name
      json.status c.asset_status.name
      json.location c.location.name
      json.technical_contact c.computertechnical_contact.user_name if c.computertechnical_contact.present?
     end
end