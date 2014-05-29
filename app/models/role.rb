class Role < ActiveRecord::Base

   #publicactivity gem
    include PublicActivity::Model
     tracked owner: ->(controller, model) { controller && controller.current_user }
     tracked ip: ->(controller,model) {controller && controller.current_user.current_sign_in_ip}
	
 #validation
    validates :title, presence:true,:if => Proc.new{|f| f.title.blank? } 
    validates_format_of :title, :with =>/\A(?=.*[a-z])[a-z\d\s\_\-]+\Z/i, :if => Proc.new{ |f| !f.title.blank? } 
    validates :title, exclusion: { in: %w(company_admin) ,:if => Proc.new{ |f| (f.title.nil?) },message: MESSAGES["roles"]["company_admin_failure"]}
    
   
	
	has_many :privileges
	has_many :roles
	belongs_to :company
end
