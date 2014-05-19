ActiveAdmin.register Location do
  menu :if => proc{ !current_admin_user.present? }

  permit_params :name, :company_id

  index do
    selectable_column
    column :name
    actions
  end
end
