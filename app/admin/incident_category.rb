ActiveAdmin.register IncidentCategory do

breadcrumb do
    [
      link_to('IncidentCategory', '/admin/incident_categories')
    ]
  end

  menu :if => proc{ !current_admin_user.present? }
permit_params :name

 index do
    # selectable_column
    column :name 
     actions
  end
  
 config.filters = false
  
  #authentication
 
end
