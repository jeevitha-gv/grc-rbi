ActiveAdmin.register IncidentPriority do

	breadcrumb do
    [
      link_to('IncidentPriority', '/admin/incident_priorities')
    ]
  end

	permit_params :name
config.filters = false
index do
    # selectable_column
    column :name 
     actions
  end

  
end
