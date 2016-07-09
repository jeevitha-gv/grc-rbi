ActiveAdmin.register PolicyStatus do

  menu :if => proc{ current_admin_user.present? }
  
   permit_params :name

  controller do
  	before_filter :authenticate_admin_user!
    before_filter :check_subdomain
  end

	form do |f|	
    	f.inputs "Add Policy Status" do
      		f.input :name
    	end
    	f.actions
   end

end