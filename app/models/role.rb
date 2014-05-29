class Role < ActiveRecord::Base

   #publicactivity gem
    include PublicActivity::Model
     tracked owner: ->(controller, model) { controller && controller.current_user }
     tracked ip: ->(controller,model) {controller && controller.current_user.current_sign_in_ip}
	
 #validation
	validates :title, exclusion: { in: %w(company_admin) ,:if => Proc.new{ |f| (f.title.nil?) },message: MESSAGES["roles"]["company_admin_failure"]}
    validates :title, presence:{message: MESSAGES["role"]["name"]["presence"]["failure"]}
    validates :title, uniqueness:{message: MESSAGES["role"]["name"]["uniqueness"]["failure"]}
	
	has_many :privileges
	has_many :roles
	belongs_to :company
end
