class AuditCompliance < ActiveRecord::Base

# Relationship
	has_many :artifact_answers , :dependent => :destroy
	has_many :artifacts, through: :artifact_answers
	belongs_to :compliance_library
	belongs_to :audit
	belongs_to :score
<<<<<<< HEAD
	has_one :checklist_recommendation, as: :checklist , :dependent => :destroy
  
=======
	has_one :checklist_recommendation, as: :checklist

>>>>>>> f32fef50d498ab48f4511e2c5ed9cdb8904da41d
  delegate :name, to: :compliance_library, prefix: true, allow_nil: true

end
