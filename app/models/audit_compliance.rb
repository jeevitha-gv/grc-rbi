class AuditCompliance < ActiveRecord::Base


# Relationship
	has_many :artifact_answers
	belongs_to :compliance_library
	belongs_to :audit
	belongs_to :score
	has_many :checklist_recommendations, as: :checklist

end
