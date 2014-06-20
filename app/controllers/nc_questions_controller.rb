class NcQuestionsController < ApplicationController

  before_filter :check_for_current_audit
  before_filter :check_for_auditee_response, :only => [:new]

  # Intialize Nc Questions for audit
  def new
		@audit = current_audit
		@nc_question = NcQuestion.new
		@audit.nc_questions.build unless @audit.nc_questions.present?
    @audit.nc_questions.first.question_options.build unless @audit.nc_questions.first.question_options.present?
	end

  # Create Nc Questions for audit
	def create
		@audit = current_audit
		if @audit.update_attributes(question_params)
      @audit.nc_questions.update_all(company_id: current_company.id)
      flash[:notice] = "Your requests were added successfully"
      redirect_to new_nc_question_path
    else
      flash[:error] = "Something went wrong and requests were not added"
			render "new"
		end
	end

	def library_questions
		@nc_questions = NcQuestion.where(:id=>params[:nc_question])
		@priorities = Priority.all
		@response_types = QuestionType.all
		@auditees = @audit.auditees.all
  end

  # Import NcQuestions from CSV file
	def import_files
		if(params[:file].present?)
      begin
				NcQuestion.build_from_import(params[:file])
        flash[:notice] = MESSAGES["nc_question"]["csv_upload"]["success"]
        redirect_to new_nc_question_path
      rescue
        flash[:notice] = MESSAGES["csv_upload"]["error"]
        redirect_to new_nc_question_path
      end
    else
      flash[:notice] = MESSAGES["csv_upload"]["presence"]
      redirect_to new_nc_question_path
    end
  end

  # Download NcQuestion sample file
  def export_files
    nc_question_csv = CSV.generate do |csv|
      csv << ["Question Name;Question Type;Mutilpe Type Options;"]
      csv_options = [["Example Question;Yes or no;"], ["Second Question;Multiple choice;question option1", " question option2", " question option3", " question option4"], ["Third Question;Descriptive type"]]
      csv_options.each do |nc_question|
        csv << nc_question
      end
    end
    send_data(nc_question_csv, :type => 'text/csv', :filename => 'sample_non_compliance_question.csv')
  end

  private
    # Strong Parameters for NcQuestions of particular Audit
		def question_params
			params.require(:audit).permit(nc_questions_attributes: [:question, :question_type_id, :priority_id, :target_date, :does_require_document, :nc_library, :auditee_id, :id, :_destroy, question_options_attributes: [:value, :id, :_destroy]])
		end

    # Filter for Authenticate auditee response based on the Audit
    def check_for_auditee_response
      if(current_audit.auditees.map(&:id).include?(current_user.id))
        redirect_to new_answers_path
      end
    end
end
