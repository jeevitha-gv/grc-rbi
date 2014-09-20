json.data do |json|
  json.array!(@assets) do |a|  	  
  	  json.id a.id
  	  json.assetable_id a.assetable_id
      json.name a.name
      json.owner a.info_asset_owner.user_name if a.info_asset_owner.present?
      json.custodian a.info_asset_custodian.user_name if a.info_asset_custodian.present?
      json.asset_type a.assetable.asset_type.name if a.assetable.asset_type.name.present?
      
     end
end