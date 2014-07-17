class Project < ActiveRecord::Base

	# Associations
  has_many :risks
	belongs_to :company

   validates :name, presence:true
   validates :name, :uniqueness => {:scope => :company_id}, :if => Proc.new{ |f| !f.name.blank? }
   validates :name, length: { maximum: 50 }, :if => Proc.new{|f| !f.name.blank? }

   scope :for_name_by_company, lambda {|title, company_id| where("name = ? AND company_id = ?", name, company_id)}
end
