json.data do |json|
  json.array!(@computers) do |a|
	  json.id a.id
	  binding.pry
	  json.start a.expiry_date if a.expiry_date.present?
	  json.end a.expiry_date if a.expiry_date.present?
    json.name a.asset.name
  end
end