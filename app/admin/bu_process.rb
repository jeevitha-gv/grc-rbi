ActiveAdmin.register BuProcess do
  config.filters = false
  menu :if => proc{ !current_admin_user.present? }

  breadcrumb do
    [
      link_to('BuProcess', '/admin/bu_processes')
    ]
  end

  permit_params :name, :company_id

  controller do
    before_filter :check_company_admin, :check_role, :company_admin_module_check
    before_filter :check_subdomain
    before_filter :check_plan_expire
   action :all, except: [:new, :show]

    #~ def scoped_collection
      #~ current_company.risk_categories
    #~ end

  end

   #Index page fields customization
  index do
    column :name
    actions
  end

  #show page fields customization
  show do
    attributes_table do
      row :id
      row :name
      row :created_at
      row :updated_at
    end
  end

  form do |f|
      f.inputs "New BuProcess" do
        f.input :name
      f.input :company_id, :as => :hidden, :input_html => { :value => current_company.id}
    end
    f.actions
  end
end
