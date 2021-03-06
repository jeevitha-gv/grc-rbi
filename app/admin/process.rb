ActiveAdmin.register CppMeasure, { :as => 'Process'} do
 config.filters = false
 menu :if => proc{ !current_admin_user.present? }

  breadcrumb do
    [
      link_to('Process', '/admin/processes')
    ]
  end

  permit_params :compliance_id, :name, :description, :duration, :measure_type, :company_id, :implementation_status_id

 controller do
    before_filter :check_company_admin, :check_role, :company_admin_module_check, :check_subdomain,:check_plan_expire
   action :all, except: [:new, :show]

    def scoped_collection
      CppMeasure.where('measure_type= ? AND company_id= ?','Process',current_company)
    end

  end

  #Index page fields customization
  index do
    column :name
    column :description
    column  "Compliance" do |c|
    c.compliance.name
    end
    column :duration
    actions
  end

  #show page fields customization
  show do
    attributes_table do

      row :name
      row :description
       row  "Compliance" do |c|
        c.compliance.name
      end
    end
  end

  form do |f|
      f.inputs "New Process" do
      f.input :name
      f.input :description
      f.input :compliance_id, :label => 'Regulation', :as => :select, :collection => Compliance.all, :prompt => "-Select Regulation-"
      f.input :duration, :label => 'Duration', :as => :select, :collection => [['Long Term','Long Term'],['Short Term','Short Term']], :prompt => "-Select Duration-"
      f.input :implementation_status_id, :label => 'Implementation Status', :as => :select, :collection => ImplementationStatus.all, :prompt => "-Select Status-"
      f.input :measure_type, :as => :hidden, :input_html => { :value => "Process"}
      f.input :company_id, :as => :hidden, :input_html => { :value => "#{current_company.id}"}
    end
    f.actions do
      f.action :submit, label: 'Create Process'
    end
  end

end
