class NcQuestionsController < ApplicationController

	def index
		@nc_questions = NcQuestion.all
	end

	def new
		@audit = current_audit
		@nc_question = NcQuestion.new
		@audit.nc_questions.build unless @audit.nc_questions.present?
    @audit.nc_questions.first.question_options.build unless @audit.nc_questions.first.question_options.present?
    # rescue
    #   @errors = "Invalid file format"
    #   redirect_to audits_path
    # end
	end


	def create
		@audit = Audit.find(params[:audit][:audit_id])
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
    # @response_type_selected = @nc_question.map(&:question_type_id)
		@auditees = @audit.auditees.all
  end

	def import_files
		if(params[:file].present?)
      begin
				spreadsheet = NcQuestion.open_spreadsheet(params[:file])
        start = 2
        (start..spreadsheet.last_row).each do |i|
          row_data = spreadsheet.row(i)[0].split(";")
					question_type = QuestionType.where("lower(name) = ?", "#{row_data[1].to_s.downcase}").first

					nc_question = NcQuestion.new
          nc_question.attributes ={:question => row_data[0], :question_type_id => question_type.present? ? question_type.id : nil}
          nc_question.save(:validate => false)

          set = 1
          options = []
          while set < 200
            options_data = spreadsheet.row(i)[set]
            options << options_data if options_data.present?
            break if options_data.blank?
            set += 1
          end

          options << row_data[2]
          if options.compact.present?
            options_array = options.collect{|x| x.strip if x.present?}
            options_array.collect{|x| nc_question.question_options.create(:value =>x) }
          end
        end
        redirect_to new_nc_question_path
      rescue
        @errors = "Invalid file format"
        redirect_to new_nc_question_path
      end
    else
      @errors = "Please select a file."
      redirect_to new_nc_question_path
    # end
    end
  end


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
		def question_params
			params.require(:audit).permit(nc_questions_attributes: [:question, :question_type_id, :priority_id, :target_date, :does_require_document, :nc_library, :auditee_id, :id, :_destroy, question_options_attributes: [:value, :id, :_destroy]])
		end
end
