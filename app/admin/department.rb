ActiveAdmin.register Department do
  menu :if => proc{ !current_admin_user.present? }

 #authentication
  controller do
    before_filter :check_company_admin, :check_role
    
     def scoped_collection
      Department.where(:location_id=>current_company.locations.map(&:id))
    end

    def create
      @department = Department.new(depart_params)
      if @department.save
        flash[:now] = MESSAGES["Department"]["create"]["success"]
        redirect_to admin_departments_path
      else
        render 'new'
      end
    end

    private
      def depart_params
        params.require(:department).permit(:name, :location_id)
      end
  end

  permit_params :name, :location_id
  
  index do
    selectable_column
    column :name
    actions
  end

  form do |f|
    f.inputs "New Department" do
      f.input :location_id, :label => 'Location', :as => :select, :collection => current_company.locations
      f.input :name
    end
    f.actions
  end
end
