json.data do |json|
  json.array!(@access_plans) do |a|  	  
  	  json.id a.id
  	  binding.pry
      json.plan a.bc_plan.plan
      json.opex a.bc_plan.opex
      json.capex a.bc_plan.capex
      json.owner a.bc_plan.plan_resp.user_name          
     end
end