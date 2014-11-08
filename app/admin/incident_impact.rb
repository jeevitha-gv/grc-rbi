ActiveAdmin.register IncidentImpact do

  breadcrumb do
    [
      link_to('IncidentImpact', '/admin/incident_impacts')
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
