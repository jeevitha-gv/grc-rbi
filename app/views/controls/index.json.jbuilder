json.data do |json|

  json.array!(@controls) do |control|
      json.id control.id
      json.name control.name
      json.owner control.owner
      json.control_regulation control.control_regulation_name    
    end
end