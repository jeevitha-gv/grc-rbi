ActiveAdmin.register Team do

      menu :if => proc{ !current_admin_user.present? }

  #authentication
  controller do
    before_filter :check_company_admin
  end
      permit_params :name

  index do
    selectable_column
    column :name
    actions
  end
form do |f|
    f.inputs "Team" do
      f.input :name
    end
    f.actions
  end  

  
end
