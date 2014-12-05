json.data do |json|
  json.array!(@frauds) do |a|    
  	  json.id a.id
  	  json.location a.location.name 
  	  json.name a.subject
      json.fraud_type a.fraud_type.name if a.fraud_type.present?
      json.investigator a.fraud_inves.user_name if a.fraud_inves.present?
      json.fraud_manager a.fraud_man.user_name if a.fraud_man.present?
     end
end
