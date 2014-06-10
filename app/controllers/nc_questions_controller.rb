class NcQuestionsController < ApplicationController
	before_filter :current_audit, :only => [:new]

	def index
		@nc_questions = NcQuestion.all

	end

	def new
		begin
		# @question_option = QuestionOption.new
		@audit.nc_questions.build unless @audit.nc_questions.present?
    	@audit.nc_questions.first.question_options.build unless @audit.nc_questions.first.question_options.present?
        rescue
	        @errors = "Invalid file format"
	        redirect_to audits_path
        end
	end


	def create
		@audit = Audit.find(params[:id])
		# @nc_questions = NcQuestion.new(question_params)
		if @audit.update_attributes(question_params)
			redirect_to nc_questions_path
		else
			render "new"
		end
	end

	private
		def question_params
			params.require(:audit).permit(:id, nc_questions_attributes: [:question, :question_type_id, :priority_id, :target_date, :does_require_document, :nc_library, :auditee_id, :id, :_destroy, question_options_attributes: [:value, :id, :_destroy]])
		end

		def current_audit
			@audit = Audit.find(params[:audit_id])
		end
end
