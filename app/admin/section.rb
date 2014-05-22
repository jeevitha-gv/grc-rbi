ActiveAdmin.register Section do

    menu :if => proc{ current_admin_user.present? }

  #authentication
  controller do
    before_filter :authenticate_admin_user!
  end

  permit_params :name

  index do
    selectable_column
    column :name
    actions
  end

  show do
    attributes_table :name
  end

end
