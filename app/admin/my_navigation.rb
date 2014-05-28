class MyNavigation < ActiveAdmin::Component
		def build(namespace, menu)
			render :partial => "/layouts/admin_header"
		end
			
end