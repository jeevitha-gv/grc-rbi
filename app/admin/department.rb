ActiveAdmin.register Department do
  menu :if => proc{ !current_admin_user.present? }
  
 #authentication
  controller do
    before_filter :check_company_admin
  end
  
  permit_params :name, :location_id  
  index do
    selectable_column
    column :name
    actions
  end
end
