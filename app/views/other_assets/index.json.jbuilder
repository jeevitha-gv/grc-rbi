json.data do |json|
  json.array!(@other_assets) do |o|  	  
  	  json.id o.id
      json.name o.name
      json.status o.asset_status.name if o. asset_status.present?
      json.location o.location.name if o.location.present?
      
     end
end