ActiveAdmin.register InvestigationObject do

  
  permit_params :name
  breadcrumb do
      [
        link_to('InvestigationObject', '/admin/investigation_objects')
      ]
    end
      menu :if => proc{ !current_admin_user.present? }
  index do
    column "Name", :name

  end
  
end
