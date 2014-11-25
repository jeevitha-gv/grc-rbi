json.data do |json|
  json.array!(@access_plans) do |a|  
   	  json.id a.id
      json.title a.title
      json.department a.department.name
      json.threat a.threat.name
      json.owner a.bc_owner.user_name          
     end
end