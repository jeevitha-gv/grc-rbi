ActiveAdmin.register Modular do
  menu :if => proc{ current_admin_user.present? }

  permit_params :controller_name, :action_name, :section_id

  index do
    selectable_column
    column :controller_name
    column :action_name
    actions
  end

  show do
    attributes_table :controller_name, :action_name, :section
  end
end
