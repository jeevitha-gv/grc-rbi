class Answer < ActiveRecord::Base

	has_many :checklist_recommendations, as: :checklist
	belongs_to :nc_question
end