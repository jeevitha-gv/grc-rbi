ActiveAdmin.register Company do

  # Remove new company creation option from ActiveAdmin
  actions :all, :except => [:new]

  index do
    column :name
    column :primary_email
    column :secondary_email
    column :address1
    column :address2
    column :timezone
    column :country_id
    column :contact_no
    actions
  end

  permit_params :name, :primary_email, :secondary_email, :address1, :address2, :timezone, :country_id, :contact_no
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  
end
