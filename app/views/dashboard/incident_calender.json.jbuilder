  json.array!(@incident) do |incident|
      json.id incident.id
      json.title incident.title
      json.start incident.date_occured
      
      
    end
  json.array!(@audit) do |audit|
      json.id audit.id
      json.title audit.title
      json.start audit.start_date
      json.start_date audit.start_date
      json.end audit.start_date
      json.end_date audit.end_date
      json.publised audit.audit_status_id
      json.auditor audit.auditory_full_name
    end
