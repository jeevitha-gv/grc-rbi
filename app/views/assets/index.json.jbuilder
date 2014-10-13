json.data do |json|
  json.array!(@access_asset) do |a|    
  	  json.id a.id
  	  json.status a.asset_state.name
  	  json.name a.name
      json.assetable_type a.assetable_type
      json.asset_value calc_score(a)
      json.custodian a.info_asset_custodian.user_name if a.info_asset_custodian.present?
      json.owner a.info_asset_owner.user_name if a.info_asset_owner.present?
      json.evaluator a.info_asset_evaluator.user_name if a.info_asset_evaluator.present?
     end
end