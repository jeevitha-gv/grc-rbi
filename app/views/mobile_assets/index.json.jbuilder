json.data do |json|
  json.array!(@mobile_assets) do |m|
      json.id m.id
      json.model m.model
      json.manufacturer m.manufacturer
      json.service_provider m.service_provider
      json.device_type m.device_type.name
     end
end