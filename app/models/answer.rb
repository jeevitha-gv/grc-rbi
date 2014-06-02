class Answer < ActiveRecord::Base

	has_many :checklist_recommendations, as: :checklist
end
