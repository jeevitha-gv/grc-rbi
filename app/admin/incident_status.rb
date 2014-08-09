ActiveAdmin.register IncidentStatus do
	permit_params :name

  config.filters = false
   permit_params :name
   index do
    # selectable_column
    column :name 
     actions
  end
  
end
