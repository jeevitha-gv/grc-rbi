ActiveAdmin.register RiskCategory, { :as => 'Category'} do

  menu :if => proc{ !current_admin_user.present? }
  
  breadcrumb do
    [
      link_to('Category', '/admin/categories')
    ]
  end
  
  permit_params :name, :company_id
  
  controller do
    before_filter :check_company_admin, :check_role
    before_filter :check_subdomain
   action :all, except: [:new, :show]

    def scoped_collection
      current_company.categories
    end
    
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
end
