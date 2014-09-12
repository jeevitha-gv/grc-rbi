json.data do |json|
  json.array!(@assets) do |a|    
  	  json.id a.id
      json.name a.name
      json.asset_state a.asset_state.name if a.asset_state.present?
      json.owner a.info_asset_owner.user_name if a.info_asset_owner.present?
      json.custodian a.info_asset_custodian.user_name if a.info_asset_custodian.present?
      json.evaluated a.info_asset_evaluator.user_name if a.info_asset_evaluator.present?
     end
end