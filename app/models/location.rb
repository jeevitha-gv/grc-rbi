class Location < ActiveRecord::Base
 #publicactivity gem
	 include PublicActivity::Model
   tracked owner: ->(controller, model) { controller && controller.current_user }
   tracked ip: ->(controller,model) {controller && controller.request.ip}

  # Validation
  validates :name, presence:true
  validates_format_of :name, :with =>/\A(?=.*[a-z])[a-z\d\s]+\Z/i, :if => Proc.new{ |f| !f.name.blank? }
  validates :name, length: { in: 2..52 }, :if => Proc.new{ |f| !f.name.blank? }
  validates_uniqueness_of :name, scope: [:company_id], :case_sensitive => false

 scope :location_name, ->(id) { where(id: id).first.name}
 scope :for_name_by_company, lambda {|location_name, company_id| where("lower(name)=? and company_id=?", location_name, company_id)}

#  has_many :departments, :dependent => :destroy
  belongs_to :company
  has_many :audits
  has_many :risks
  # Assosciations with Asset Module
  has_many :other_assets
  has_many :contracts
  has_many :computers
  has_many :mobile_assets

  #  Associations with Policy Module
  has_many :policies

end
