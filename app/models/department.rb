class Department < ActiveRecord::Base
  #publicactivity gem
  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller && controller.current_user }
  tracked ip: ->(controller,model) {controller && controller.request.ip}

  # associations
  has_many :audits
  #belongs_to :location
  has_many :risks
  belongs_to :company

  # Assosciations with Asset Module
  has_many :other_assets
  has_many :contracts
  has_many :mobile_assets
  has_many :services
  has_many :documents
  has_many :assets

  # validations
  validates :name, presence:true
  validates_format_of :name, :with =>/\A(?=.*[a-z])[a-z.! @ # $ % ^ & * ( ) _ - + =\d\s]+\Z/i,:if => Proc.new{|f| !f.name.blank? }
  validates :name, length: { maximum: 50 }, :if => Proc.new{|f| !f.name.blank? }
  validates_uniqueness_of :name, scope: [:company_id], :case_sensitive => false
  # validates_uniqueness_of :name, scope: [:location_id], :case_sensitive => false
  # validates :location_id, presence:true

  #scope
 # scope :for_location, lambda {|location_id| where(location_id: location_id)}
  scope :department_name, ->(id) { where(id: id).first.name}
  scope :for_name_by_company, lambda {|department_name, company_id| where("lower(name)=? and company_id=?", department_name, company_id)}
  #scope :for_name_by_location, lambda  {|department_name, location_id| where("lower(name) = ? and location_id=?", department_name, location_id)}

end
