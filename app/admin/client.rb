ActiveAdmin.register Client do

  menu :if => proc{ !current_admin_user.present? }

  permit_params :name, :company_id, :address1, :address2, :contact_no, :email
  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  index do
    column :name
    column :company_id
    column :address1
    column :address2
    column :contact_no
    column :email
    actions
  end
#   form do |f|
#   f.inputs "Clients Details" do
#     f.input :name
#     f.input :company_id
#     f.input :address1
#     f.input :address2
#     f.input :contact_no
#     f.input :email
#   end
#   f.actions
# end
end
