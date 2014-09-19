ActiveAdmin.register ApprovalAction do

  menu :if => proc{ current_admin_user.present? }
  
end
