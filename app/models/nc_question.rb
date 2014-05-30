class NcQuestion < ActiveRecord::Base

	#Assosciations
	belongs_to :question_type
	belongs_to :priority
	belongs_to :company
	belongs_to :auditee_id, :class_name => "User"
	belongs_to :audit

	#Validations
	validates :question, presence: true
	validates :target_date, presence: true

end
