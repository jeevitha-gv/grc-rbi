ActiveAdmin.register Department do
  menu :if => proc{ !current_admin_user.present? }

 #authentication
  controller do
    before_filter :check_company_admin
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

  controller do
    private
    def scoped_collection
      Department.where(:location_id=>current_company.locations.map(&:id))
    end
  end

end
