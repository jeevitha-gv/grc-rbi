class Location < ActiveRecord::Base
 #publicactivity gem
	 include PublicActivity::Model
   tracked owner: ->(controller, model) { controller && controller.current_user }
   tracked ip: ->(controller,model) {controller && controller.current_user.current_sign_in_ip}
  
  # Validation
  validates :name, presence:true, :if => Proc.new{|f| f.name.blank? } 
  validates_format_of :name, :with =>/\A(?=.*[a-z])[a-z\d]+\Z/i, :if => Proc.new{ |f| !f.name.blank? } 
  validates :name, length: { in: 4..52 }, :if => Proc.new{ |f| !f.name.blank? } 
  
  
  
  has_many :departments
  belongs_to :company

end
