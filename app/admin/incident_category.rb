ActiveAdmin.register IncidentCategory do

permit_params :name

 index do
    # selectable_column
    column :name 
     actions
  end
  
 config.filters = false
  
  #authentication
 
end
