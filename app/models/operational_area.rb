class OperationalArea < ActiveRecord::Base

 # Relationship
 has_many :audit_operational_weightages
 belongs_to :compliance_library

 delegate :name, to: :compliance_library, prifix: true 
end
