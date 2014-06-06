class NcQuestion < ActiveRecord::Base

	#Assosciations
	belongs_to :question_type
	belongs_to :priority
	belongs_to :company
	belongs_to :auditee, :class => "User", foreign_key: :auditee_id
	belongs_to :audit
	has_many :question_options
	has_many :answers
	accepts_nested_attributes_for :question_options, :allow_destroy => true
	has_many :checklist_recommendations, as: :checklist


	#Validations
	validates :question, presence: true
	validates :target_date, presence: true

	

end
