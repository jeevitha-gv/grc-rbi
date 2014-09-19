ActiveAdmin.register Audience do

  menu :if => proc{ current_admin_user.present? }
  
end
