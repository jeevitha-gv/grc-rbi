json.data do |json|
  json.array!(@access_asset) do |a|    
  	  json.id a.id
      json.assetable_type a.assetable_type
      json.custodian a.info_asset_custodian.user_name if a.info_asset_custodian.present?
      json.owner a.info_asset_owner.user_name if a.info_asset_owner.present?
     end
end