class AuditCompliance < ActiveRecord::Base


# Relationship
	has_many :artifact_answers
	has_many :artifacts, through: :artifact_answers
	belongs_to :compliance_library
	belongs_to :audit
	belongs_to :score
	has_one :checklist_recommendation, as: :checklist
  
  delegate :name, to: :compliance_library, prefix: true, allow_nil: true

end
