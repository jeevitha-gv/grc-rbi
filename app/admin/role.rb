ActiveAdmin.register Role do
 
 controller do
  before_filter :authenticate_admin_user!
 end
 
  permit_params :title, :company_id
  
  
end
