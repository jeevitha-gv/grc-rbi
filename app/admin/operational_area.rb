ActiveAdmin.register OperationalArea do

  menu :if => proc{ current_admin_user.present? }


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

  
end
