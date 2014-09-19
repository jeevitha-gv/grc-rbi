ActiveAdmin.register ReviewAction do

  
  menu :if => proc{ current_admin_user.present? }
  
end
