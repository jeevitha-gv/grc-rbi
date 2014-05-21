ActiveAdmin.register Location do
  menu :if => proc{ !current_admin_user.present? }
  
  permit_params :name, :company_id

  controller do
    #publicactivity gem
    include PublicActivity::StoreController  
  
    def create
      @location = Location.new(location_params)
      @location.company_id = current_user.company_id
      if @location.save
        redirect_to admin_locations_path
      else
        redirect_to new_admin_location_path
      end

    end

    private
      def location_params
        params.require(:location).permit(:name, :company_id)
      end
  end

  index do
    selectable_column
    column :name
    actions
  end

  form do |f|
    f.inputs "New Location" do
      f.input :name
    end
    f.actions
  end
end
