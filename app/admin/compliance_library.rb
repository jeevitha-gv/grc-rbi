ActiveAdmin.register ComplianceLibrary do

  permit_params :compliance_id, :name, :is_leaf, :parent_id 
  
  #authentication for superadmin
  controller do
    before_filter :authenticate_admin_user!

    def scoped_collection
  		ComplianceLibrary.all
  	end
    
    def compliance_domains
      p domains = ComplianceLibrary.all.group_by(&:parent_id).collect {|k,v| v}[0].collect {|x| x unless x.is_leaf }
      render json: {:data=> domains}
    end
       
    def compliance_control_objectives
			control_objectives = ComplianceLibrary.where("parent_id= ? AND is_leaf= ?",params[:id], false)
			render json: {:data=> control_objectives}
    end
       
		def compliance_controls
			control_objectives = ComplianceLibrary.where("parent_id= ? AND is_leaf= ?",params[:id], true)
			render json: {:data=> control_objectives}
		end
    
    def destroy
      compliance_library = ComplianceLibrary.where('id= ?', params[:id]).first
      compliance_library.destroy
			render json: {:data=> "success"}
    end
    
  end
  
  #Index page fields customization
 index do
    render "index"
  end
  
  #show page fields customization
  show do
    attributes_table do
      row :id
      row :name
      row "Compliance" do |compliance|
        compliance.compliance_name
      end
      row :is_leaf
      row "Parent" do |compliance_library|
        ComplianceLibrary.where('id= ?', compliance_library.parent_id).first.name if compliance_library.parent_id.present?
      end
      row :created_at
      row :updated_at
    end
  end
  
  #ComplianceLibrary creation form customization
 
  form do |f|
    id = params[:compliance_library_id] ? params[:compliance_library_id] : params[:control_objective_id]
    compliance = ComplianceLibrary.where('id= ?', id).first
    f.inputs "ComplianceLibrary" do
			if params[:action] == 'new'
				if (params[:compliance_library_id].nil? && params[:control_objective_id].nil?)
					f.input :compliance_id, :as => :select, :collection => Compliance.all, :prompt => "-Select Compliance-"
        else
          f.input :compliance_id, :as => :hidden, :input_html => { :value => "#{compliance.compliance_id if compliance}"}
				end
				f.input :name
        f.input :parent_id, :as => :hidden, :input_html => { :value => "#{id}"}
        unless params[:control_objective_id].nil?
          f.input :is_leaf, :as => :hidden, :input_html => { :value => "true"}
        else
          f.input :is_leaf, :as => :hidden, :input_html => { :value => "false"}
				end
			else
        parent_compliance = ComplianceLibrary.where('parent_id= ? AND is_leaf= ?', params[:id], false).first
        unless parent_compliance.nil?
          f.input :compliance_id, :as => :select, :collection => Compliance.all, :prompt => "-Select Compliance-"
        end
        #~ f.input :parent, :as => :hidden, :input_html => {:value =>params[:id] }
				f.input :name
				
			end
    end
    f.actions
  end
  
end
