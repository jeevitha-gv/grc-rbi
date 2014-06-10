class OperationalArea < ActiveRecord::Base

 # Relationship
 has_many :audit_operational_weightages
 belongs_to :compliance_library
 belongs_to :company

 delegate :name, to: :compliance_library, prefix: true, allow_nil: true

 # validation
 validates :compliance_library_id ,:uniqueness => {:scope => :company_id}
 validates :weightage, :numericality => { :greater_than_or_equal_to => 1, :less_than_or_equal_to => 5, :only_integer => true}
end
