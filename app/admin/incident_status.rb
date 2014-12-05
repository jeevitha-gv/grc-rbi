ActiveAdmin.register IncidentStatus do
	
	breadcrumb do
    [
      link_to('IncidentStatus', '/admin/incident_statuses')
    ]
  end



	permit_params :name

  config.filters = false
   permit_params :name
   index do
    # selectable_column
    column :name 
     actions
  end
  
end
