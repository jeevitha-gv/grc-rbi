json.data do |json|
  json.array!(@other_assets) do |p|
      json.id p.id
      json.name p.name
      json.status p.asset_status.name
      json.owner p.otherasset_owner.user_name
      json.user p.otherasset_user.user_name
      json.location p.location.name
      end
end