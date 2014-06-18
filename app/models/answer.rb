class Answer < ActiveRecord::Base

	has_one :checklist_recommendation, as: :checklist
	belongs_to :nc_question
	has_one :attachment , as: :attachable

  delegate :question, :to => :nc_question
  delegate :question_type_id, :to => :nc_question

  # validates :detailed_value, presence:true
  # validates :value, presence:true
end
