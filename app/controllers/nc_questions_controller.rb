class NcQuestionsController < ApplicationController

	def index
		@nc_questions = NcQuestion.all
	end

	def new
		@nc_question = NcQuestion.new
	end

	def create
		@nc_question = NcQuestion.new(question_params)
		if @nc_question.save
			redirect_to nc_questions_path
		else
			render new
		end
	end

	def question_params
		params.require(:nc_question).permit(:question, :question_type_id, :priority_id, :target_date, :does_require_document, :nc_library, :auditee_id)
	end

end
