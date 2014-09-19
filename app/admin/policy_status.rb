ActiveAdmin.register PolicyStatus do

  menu :if => proc{ current_admin_user.present? }
  
end
