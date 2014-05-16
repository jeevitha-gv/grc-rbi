ActiveAdmin.register Role do
 menu :if => proc{ !current_admin_user.present? }
 #authentication
  controller do
   #~ before_filter :authenticate_admin_user!
  end
 
  permit_params :title, :company_id
  
  
end
