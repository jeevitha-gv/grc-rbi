class Project < ActiveRecord::Base

	# Associations
  has_many :risks
	belongs_to :company

   validates :name, presence:true
   validates :name, :uniqueness => {:scope => :company_id}, :if => Proc.new{ |f| !f.name.blank? }
   validates :name, length: { maximum: 50 }, :if => Proc.new{|f| !f.name.blank? }
   validates :order, :numericality => { :greater_than_or_equal_to => 1, :less_than_or_equal_to => 20, :only_integer => true}
   scope :for_name_by_company, lambda {|title, company_id| where("name = ? AND company_id = ?", name, company_id)}
end
