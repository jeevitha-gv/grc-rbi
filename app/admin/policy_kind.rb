ActiveAdmin.register PolicyKind do

 menu :if => proc{ current_admin_user.present? }
  
end
