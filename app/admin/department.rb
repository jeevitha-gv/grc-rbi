ActiveAdmin.register Department do
  menu :if => proc{ !current_admin_user.present? }

  permit_params :name, :location_id  
  index do
    selectable_column
    column :name
    actions
  end
end
