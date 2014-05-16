ActiveAdmin.register_page "Settings" do
	
	menu :if => proc{ !current_admin_user.present? }
	controller do
      #~ before_filter :authenticate_admin_user!
	end

	
		
end