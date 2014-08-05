ActiveAdmin.register IncidentCategory do

  
 config.filters = false
   menu :if => proc{ !current_admin_user.present? }
  #authentication
  controller do
    before_filter :authenticate_admin_user!
    before_filter :check_subdomain
  end
end
