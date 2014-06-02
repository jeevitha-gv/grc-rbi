class ComplianceLibrary < ActiveRecord::Base

 # Relationship
 has_many :operational_areas
 belongs_to :compliance
 has_many :artifacts
 has_many :audit_compliances

 #Validations
 validates :compliance_id, presence: true
 validates :name, presence: true

 delegate :name, to: :compliance, prefix: true, allow_nil: true
 delegate :parent_id, to: :compliance_library, prefix: true, allow_nil: true
end
