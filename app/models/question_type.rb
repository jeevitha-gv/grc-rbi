class QuestionType < ActiveRecord::Base
validates :name, presence: true, uniqueness:{ message: MESSAGES["uniqueness"]["create"]["failure"]}
end
