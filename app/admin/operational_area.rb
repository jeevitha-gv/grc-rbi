ActiveAdmin.register OperationalArea do

  menu :if => proc{ current_admin_user.present? }

  actions :all, :except => [:destroy]

  index do
  	column "Domain" do |c|
  		c.compliance_library.name
  	end
  	column :weightage
  	actions
  end

  form do |f|
  	f.inputs "Operational Area Weightage" do
  		f.input :compliance_library_id , :label => 'Domain', :as => :select, :collection => ComplianceLibrary.all , :prompt => "-Select Domain-"
  		f.input :weightage
  	end
  	f.actions
  end

  show do
  	attributes_table do
  		row "Domain" do |c|
  			c.compliance_library.name	
  		end	
  		row :weightage
  	end
  end

  permit_params :compliance_library_id, :weightage


  controller do 

    def create
      @operational_area = OperationalArea.new(operational_area_params)
      @operational_area.company_id = current_user.company_id
      if @operational_area.save 
        redirect_to admin_operational_areas_path
      else
        render 'new'
      end
    end


    private

    def operational_area_params
      params.require(:operational_area).permit(:compliance_library_id, :weightage ,:company_id)
    end

  end
  
end
