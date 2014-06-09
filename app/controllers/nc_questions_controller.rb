class NcQuestionsController < ApplicationController

	def index
		@nc_questions = NcQuestion.all
	end

	def new
		@audit = Audit.first
		@nc_question = NcQuestion.new
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

	def library_questions
		@nc_questions = NcQuestion.where(:id=>params[:nc_question])
		@priorities = Priority.all
		@response_types = QuestionType.all
		@audit = Audit.find_by_id(params[:audit_id])
		@auditees = @audit.auditees.all
	end

	def question_params
		params.require(:audit).permit(nc_questions_attributes: [:question, :question_type_id, :priority_id, :target_date, :does_require_document, :nc_library, :auditee_id, :id, :_destroy, question_options_attributes: [:value, :id, :_destroy]])
	end

end
