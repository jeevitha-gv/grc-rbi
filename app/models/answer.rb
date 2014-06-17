class Answer < ActiveRecord::Base

	has_one :checklist_recommendation, as: :checklist
	belongs_to :nc_question
	has_many :attachments , as: :attachable
	
  delegate :question, :to => :nc_question
  delegate :question_type_id, :to => :nc_question
end
