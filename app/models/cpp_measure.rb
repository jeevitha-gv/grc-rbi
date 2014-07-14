class CppMeasure < ActiveRecord::Base

  # Associations
  belongs_to :company
  belongs_to :implementation_status
  belongs_to :compliance
  # has_many :control_measures
  #Validations
  validates :name, presence: true
  validates :name, :uniqueness => {:scope => :company_id}, :if => Proc.new{ |f| !f.name.blank? }
  validates_format_of :name, :with =>/\A(?=.*[a-z])[a-z\d\s]+\Z/i, :if => Proc.new{ |f| !f.name.blank? }
  validates :name, length: { maximum: 250 }, :if => Proc.new{|f| !f.name.blank? }
  validates :description, presence: true
  validates :compliance_id, presence: true
  validates :company_id, presence: true

  scope :for_type_by_company, lambda {|measure_type, company_id| where("measure_type = ? AND company_id = ?", measure_type, company_id)}



end