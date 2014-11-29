json.array!(@computers) do |a|
  json.id a.id
  json.title a.name
  if a.assetable_type == 'Computer'
  	json.start a.assetable.expiry_date if a.assetable.expiry_date.present?
	  json.end a.assetable.expiry_date if a.assetable.expiry_date.present?
	  json.start_date a.assetable.expiry_date
	  json.end_date a.assetable.expiry_date
  end
  if a.assetable_type == 'InformationAsset'
  	json.start a.assetable.expiry_date if a.assetable.expiry_date.present?
	  json.end a.assetable.expiry_date if a.assetable.expiry_date.present?
	  json.start_date a.assetable.expiry_date
	  json.end_date a.assetable.expiry_date
  end
end
