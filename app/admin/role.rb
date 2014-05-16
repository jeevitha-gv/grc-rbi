ActiveAdmin.register Role do
 
 #authentication
  controller do
   before_filter :authenticate_admin_user!
  end
 
  permit_params :title, :company_id
  
  
end
