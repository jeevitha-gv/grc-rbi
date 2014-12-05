  json.array!(@incident) do |incident|
      json.id incident.id
      json.title incident.title
      json.start incident.date_occured  
    end
 