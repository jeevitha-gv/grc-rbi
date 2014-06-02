class AuditCompliance < ActiveRecord::Base


# Relationship
	has_many :artifact_answers
	belongs_to :compliance_library
	belongs_to :audit
	

end
