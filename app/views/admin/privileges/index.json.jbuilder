json.data do |json|
  json.array!(@privileges) do |model|
      json.id model.id
      json.role_id model.role_id
      json.modular_id model.modular_id
    end
end