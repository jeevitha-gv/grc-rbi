class NcQuestionsController < ApplicationController

	def index
		@nc_questions = NcQuestion.all
	end

	def new
		@audit = Audit.new
		@nc_question = NcQuestion.new
		1.times do
			nc_question = @audit.nc_questions.build 
		#@nc_question.question_options.build unless @nc_question.question_options.present?
    end
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
		params.require(:nc_question).permit(:question, :question_type_id, :priority_id, :target_date, :does_require_document, :nc_library, :auditee_id, question_options_attributes: [:value])
	end

end
