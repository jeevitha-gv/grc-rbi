class OperationalArea < ActiveRecord::Base

 # Relationship
 has_many :audit_operational_weightages
 belongs_to :compliance_library
 belongs_to :company

 delegate :name, to: :compliance_library, prefix: true
end
