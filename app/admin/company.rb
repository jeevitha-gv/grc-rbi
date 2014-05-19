ActiveAdmin.register Company do

  menu :if => proc{ current_admin_user.present? }
  #authentication
  controller do
    before_filter :authenticate_admin_user!
  end
  # Remove new company creation option from ActiveAdmin
  actions :all, :except => [:new, :destroy]

  index do
    column :name
    column :primary_email
    column :secondary_email
    column :domain
    column :address1
    column :address2
    column :timezone
    column :country_id
    column :contact_no
    column :is_disabled
    actions
  end

  permit_params :name, :primary_email, :secondary_email, :domain, :address1, :address2, :timezone, :country_id, :contact_no, :is_disabled
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  
end
