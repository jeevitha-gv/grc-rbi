class Technology < ActiveRecord::Base

  # Associations
  has_many :risks
  belongs_to :company

  # Scopes
  scope :for_company, lambda {|id| where(:company_id => [id, nil] ) }
  scope :for_name_by_company, lambda { |technology_name, company_id| where("lower(name)=? and company_id=?", technology_name, company_id) }

  # Validations
  validates :name, presence:true
  validates :name, :uniqueness => {:scope => :company_id}, :if => Proc.new{ |f| !f.name.blank? }

end
