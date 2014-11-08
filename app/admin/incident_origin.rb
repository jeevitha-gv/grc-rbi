ActiveAdmin.register IncidentOrigin do

	breadcrumb do
    [
      link_to('IncidentOrigin', '/admin/incident_origins')
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
