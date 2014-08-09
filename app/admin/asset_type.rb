ActiveAdmin.register AssetType do

   config.filters = false
   menu :if => proc{ !current_admin_user.present? }

   breadcrumb do
     [
       link_to('Asset Type', '/admin/asset_types')
     ]
   end

   permit_params :company_id, :name

   controller do
     before_filter :check_company_admin, :check_role, :company_admin_module_check, :check_subdomain,:check_plan_expire
     action :all, except: [:new, :show]
     def scoped_collection        
        current_company.asset_types
     end
   end

   index do
     column :name
     actions
   end

   show do
     attributes_table do
       row :name
     end
   end

   form do |f|
     f.inputs "New Asset Type" do
       f.input :name
       f.input :company_id, :as => :hidden, :input_html => { :value => "#{current_company.id}"}
     end
     f.actions do
       f.action :submit, label: 'Create Process'
     end
   end

end
