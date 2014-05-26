class Role < ActiveRecord::Base

   #publicactivity gem
    include PublicActivity::Model
     tracked owner: ->(controller, model) { controller && controller.current_user }
     tracked ip: ->(controller,model) {controller && controller.current_user.current_sign_in_ip}
		
	has_many :privileges
	has_many :roles
	belongs_to :company
end
