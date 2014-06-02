ActiveAdmin.register OperationalArea do

  menu :if => proc{ current_admin_user.present? }

  actions :all, :except => [:destroy]

  index do
  	column "ComplianceLibrary" do |c|
  		c.compliance_library.name
  	end
  	column :weightage
  	actions
  end

  form do |f|
  	f.inputs "Operational Area Weightage" do
      all_compliance = ComplianceLibrary.all.group_by(&:parent_id).collect {|k,v| v}[0].collect {|x| x unless x.is_leaf }
  		f.input :compliance_library_id , :label => 'ComplianceLibrary', :as => :select, :collection => all_compliance, :prompt => "-Select Domain-"
  		f.input :weightage
  	end
  	f.actions
  end

  show do
  	attributes_table do
  		row "ComplianceLibrary" do |c|
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

    def scoped_collection
      current_company.operational_areas
    end

  end
  
end
