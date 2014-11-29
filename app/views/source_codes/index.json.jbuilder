json.data do |json|
  json.array!(@assets) do |a|    
	  json.id a.id
	  json.assetable_id a.assetable_id
    json.name a.name 
    json.owner a.info_asset_owner.user_name if a.info_asset_owner.present?
    json.custodian a.info_asset_custodian.user_name if a.info_asset_custodian.present?
  end
end