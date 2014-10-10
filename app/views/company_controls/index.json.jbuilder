json.data do |json|
  	json.array!(@company_controls) do |control|
    	json.id control.id
    	json.title control.title
    	
  	end
end