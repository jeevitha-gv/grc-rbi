class RiskCategory < ActiveRecord::Base

  has_many :risks
  belongs_to :company

  # Scopes
  scope :for_company, lambda {|id| where(:company_id => [id, nil] ) }
  scope :for_name_by_company, lambda { |category_name, company_id| where("lower(name)=? and company_id=?", category_name, company_id) }

  # Validations
  validates :name, presence:true
  validates :name, :uniqueness => {:scope => :company_id}, :if => Proc.new{ |f| !f.name.blank? }

end
