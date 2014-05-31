class ComplianceLibrary < ActiveRecord::Base

 # Relationship
 has_many :operational_areas
 belongs_to :compliance

 delegate :name, to: :compliance, prefix: true, allow_nil: true
 delegate :parent_id, to: :compliance_library, prefix: true, allow_nil: true
end
