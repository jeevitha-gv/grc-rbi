ActiveAdmin.register Client do

  menu :if => proc{ !current_admin_user.present? }
   #authentication
  controller do
    before_filter :check_company_admin
  end
  permit_params :name, :company_id, :address1, :address2, :contact_no, :email

  index do
    column :name
    column :company_id
    column :address1
    column :address2
    column :contact_no
    column :email
    actions
  end
  form do |f|
    f.inputs "Clients Details" do
      f.input :name
      f.input :address1
      f.input :address2
      f.input :contact_no
      f.input :email
    end
    f.actions
  end
end
