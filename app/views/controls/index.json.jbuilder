json.data do |json|

  json.array!(@controls) do |control|
      json.id control.controlid
      json.name control.name
      json.owner control.owner
      json.control_regulation_id control.control_regulation_id    
    end
end