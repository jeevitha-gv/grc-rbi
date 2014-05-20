ActiveAdmin.register_page "Settings" do
	
	menu :if => proc{ !current_admin_user.present? }

end