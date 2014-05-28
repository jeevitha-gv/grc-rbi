class Role < ActiveRecord::Base

   #publicactivity gem
    include PublicActivity::Model
     tracked owner: ->(controller, model) { controller && controller.current_user }
     tracked ip: ->(controller,model) {controller && controller.current_user.current_sign_in_ip}
	
	validates :title, exclusion: { in: %w(company_admin) ,message: MESSAGES["roles"]["company_admin_failure"]} 

	
	has_many :privileges
	has_many :roles
	belongs_to :company
end
