class NcQuestionsController < ApplicationController

	def index
		@nc_questions = NcQuestion.all
	end

	def new
		@audit = Audit.first
		@nc_question = NcQuestion.new
		@question_option = QuestionOption.new
		1.times do
			nc_question = @audit.nc_questions.build 			
		#@nc_question.question_options.build unless @nc_question.question_options.present?
    	end
    	1.times do
    		question_option = @nc_question.question_options.build
    	end
	end

	def create
		@audit = Audit.first		
		if @audit.update_attributes(question_params)
			redirect_to nc_questions_path
		else
			render "new"
		end
	end

	def question_params
		params.require(:audit).permit(nc_questions_attributes: [:question, :question_type_id, :priority_id, :target_date, :does_require_document, :nc_library, :auditee_id, question_options_attributes: [:value]])
	end

end
