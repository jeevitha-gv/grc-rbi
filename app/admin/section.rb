ActiveAdmin.register Section do
  
  #authentication
  controller do
    before_filter :authenticate_admin_user!
  end
  
  permit_params :name

  index do
    selectable_column
    id_column
    column :name
    actions
  end

  show do
  end

end
