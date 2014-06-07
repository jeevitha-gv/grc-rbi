class NcQuestionsController < ApplicationController

	def index
		@nc_questions = NcQuestion.all
	end

	def new
		@audit = Audit.first
		@audit.nc_questions.build unless @audit.nc_questions.present?			
    	@audit.nc_questions.first.question_options.build unless @audit.nc_questions.first.question_options.present?	
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
		params.require(:audit).permit(nc_questions_attributes: [:question, :question_type_id, :priority_id, :target_date, :does_require_document, :nc_library, :auditee_id, :id, :_destroy, question_options_attributes: [:value, :id, :_destroy]])
	end

end
