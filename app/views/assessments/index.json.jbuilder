json.data do |json|
  json.array!(@access_asset) do |a|    
  	  json.id a.id
      json.assetable_type a.assetable_type
      json.custodian a.info_asset_custodian.user_name if a.info_asset_custodian.present?
      json.evaluated a.info_asset_evaluator.user_name if a.info_asset_evaluator.present?
     end
end