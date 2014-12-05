json.data do |json|
  json.array!(@access_plans) do |a|  
   	  json.id a.id
      json.title a.title
      json.department a.department.name if a.department.present?
      json.threat a.threat.name if a.threat.present?
      json.owner a.bc_owner.user_name          
     end
end