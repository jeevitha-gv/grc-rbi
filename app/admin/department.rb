ActiveAdmin.register Department do
  config.filters = false
  breadcrumb do
    [
      link_to('Department', '/admin/departments')
    ]
  end

  menu :if => proc{ !current_admin_user.present? }

 #authentication
  controller do
    #publicactivity gem
    include PublicActivity::StoreController

    before_filter :check_company_admin, :check_role
    before_filter :check_subdomain,:check_plan_expire

    def scoped_collection
      current_company.departments
    end

    def create
      @department = Department.new(depart_params)
      @department.company_id = current_user.company_id
      if @department.save
        flash[:now] = MESSAGES["Department"]["create"]["success"]
        redirect_to admin_departments_path
      else
        render 'new'
      end
    end

    private
      def depart_params
        params.require(:department).permit(:name, :company_id)
      end
  end

  permit_params :name
  index do
    selectable_column
    column :name
    actions
  end

  show do
    attributes_table :name
  end

  form do |f|
    f.inputs "New Department" do
     # f.input :location_id, :label => 'Location', :as => :select, :collection => current_company.locations, :prompt => "-Select Location-"
      f.input :name
    end
    f.actions
  end
end
