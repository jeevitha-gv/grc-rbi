json.data do |json|
  json.array!(@assets) do |a|
      json.id a.id
      json.name a.name
      json.owner a.info_asset_owner.user_name if a.info_asset_owner.present?
      json.custodian a.info_asset_custodian.user_name if a.info_asset_custodian.present?
      json.service_type a.assetable.service_type.name if a.assetable.service_type.name.present?
      
     end
end