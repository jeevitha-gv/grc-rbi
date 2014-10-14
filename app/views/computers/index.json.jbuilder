json.data do |json|
  json.array!(@assets) do |a|  	  
  	  json.id a.id
  	  json.assetable_id a.assetable_id
      json.name a.name
      json.asset_state a.asset_state.name if a.asset_state.present?
      json.computer_category a.assetable.computer_category.name
      json.asset_value calc_score(a)
      json.owner a.info_asset_owner.user_name if a.info_asset_owner.present?
      json.custodian a.info_asset_custodian.user_name if a.info_asset_custodian.present?      
      
     end
end