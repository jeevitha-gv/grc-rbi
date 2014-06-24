class AuditsController < ApplicationController
  before_filter :current_audit, only: [:show, :asc_calculation, :audit_dashboard, :artifacts_download  ]
  load_and_authorize_resource :except => [:department_teams_users, :audit_with_status, :audit_all, :index, :asc_calculation]
  before_filter :authorize_audit, :only => [:edit, :update]
  before_filter :check_company_disabled
  before_filter :audit_auditor_users, :only => [:new, :create, :edit, :update]

  # Intialize new audit
  def new
    @audit = Audit.new
    @audit.build_skipped_audit_reminder
  end

  # Edit Individual audit
  def edit
    @audit = Audit.find(params[:id])
    audit_initializers(@audit.location_id, @audit.department_id, @audit.team_id)
  end

  # Create Individual audit
  def create
    @audit = Audit.new(audit_params)
    @audit.company_id = current_company.id
    @audit.audit_status_id = (params[:commit] == "Save as Plan" ?  AuditStatus.for_name("Planning").id : AuditStatus.for_name("In Progress").id)
    if @audit.save
      SkippedAuditReminder.create(audit_id: @audit.id, skipped_by: current_user.id) if params[:skip_reminder] == "true"
      ReminderMailer.delay.notify_auditor_about_audit(@audit)
      ReminderMailer.delay.notify_auditees_about_audit(@audit)
      redirect_to audits_path
    else
      audit_initializers(@audit.location_id, @audit.department_id, @audit.team_id)
      render 'new'
    end
  end

  # Show audit and render to pdf
  def show
    respond_to do |format|
      format.html
      format.pdf do
        @pdf = (render_to_string pdf: "PDF", template: "audits/show.pdf.erb", layout: 'layouts/pdf.html.erb', encoding: "UTF-8")
        send_data(@pdf, type: "application/pdf", filename: @audit.title)
      end
    end
  end

   # Update individual audits
  def update
    @audit = Audit.find(params[:id])
    if @audit.update_attributes(audit_params)
      redirect_to edit_audit_path
    else
      audit_initializers(@audit.location_id, @audit.department_id, @audit.team_id)
      render 'edit'
    end
  end

  # list audits based on status for current user
  def audit_with_status
     @audits = current_user.accessible_audits.select{|x| x.audit_status_id == params[:audit_status_id].to_i}
  end

  # List all audits for current user
  def audit_all
    if params[:stage].present?
      @audits = current_user.audits_stage(params)
    else
      @audits = current_user.accessible_audits
    end
  end

  #audit intializer data
  def department_teams_users
    audit_initializers(params[:location_id], params[:department_id], params[:team_id])
    render 'department_locations_list'
  end

  # Import audit from csv list
  def audit_imports
    if(params[:file].present?)
      begin
        Audit.import_from_file(params[:file], current_company)
        flash[:notice] = MESSAGES["audit"]["csv_upload"]["success"]
        redirect_to audits_path
      rescue
        flash[:notice]=  MESSAGES["csv_upload"]["error"]
        redirect_to new_audit_path
      end
    else
      flash[:notice]=  MESSAGES["csv_upload"]["presence"]
      redirect_to new_audit_path
    end
  end

  # download sample audit
  def audit_export
    begin
      file_to_download = "sample_audit.csv"
      send_file Rails.public_path + file_to_download, :type => 'text/csv; charset=iso-8859-1; header=present', :disposition => "attachment; filename=#{file_to_download}", :stream => true, :buffer_size => 4096
    rescue
      flash[:error] = MESSAGES["csv_export"]["error"]
      redirect_to new_audit_path
    end
  end


  def asc_calculation
    status_id = AuditStatus.where('name= ?','Published').first.id
    unless @audit.audit_status_id == status_id
      @audit.update(audit_status_id: status_id)
      @audit.audit_operational_weightage(current_company)
    end
    redirect_to "/audits/audit_dashboard"
  end

  def audit_dashboard
      @audit_domains, @audit_weightage, @audit_maximum_score , @audit_percentage= @audit.maximum_actual_score
      @to_do_list = @audit.compliance_checklist_recommendations
      @audit_users = @audit.audit_users
      @checklist_completed_count, @checklist_pending_count, @recommendation_completed_count, @recommendation_pending_count, @observation_completed_count, @observation_pending_count,@response_completed_count, @response_pending_count = @audit.audit_status_records
  end

  def artifacts_download
		@folder = @audit.artifact_answers.collect {|x| x.attachments}.flatten
		temp = Tempfile.new("zip-file-#{Time.now}")
		Zip::ZipOutputStream.open(temp.path) do |z|
			@folder.each do |file|
				z.put_next_entry(File.basename(file.attachment_file_url))
				z.print IO.read("#{Rails.root}/public/#{file.attachment_file_url}")
			end
		end
		send_file temp.path, :type => 'application/zip', :disposition => 'attachment', :filename => "artifacts.zip"
  end

  protected
    def audit_initializers(location_id=nil, department_id=nil, team_id=nil)
      @departments = Department.for_location(location_id) if location_id
      @teams = Team.for_department_and_company(department_id, current_company.id) if department_id
      @team = Team.for_id(team_id).last if team_id
    end

  private

    def audit_params
      params.require(:audit).permit(:title, :objective, :deliverables, :context, :issue, :scope, :methodology, :client_id, :audit_type_id, :audit_status_id, :compliance_type, :standard_id, :department_id, :team_id, :location_id, :auditor, :start_date, :end_date, audit_auditees_attributes: [:id, :user_id])
    end

    def current_company_disabled
      if Company.find(current_user.company_id).is_disabled == true
        sign_out :user
        redirect_to new_user_session_path
      end
    end

    def audit_auditor_users
      @auditor_users = current_company.users
    end

    def authorize_audit
      @audit = Audit.find_by_id(params[:id])
      redirect_to audits_path if (@audit.auditor != current_user.id)
    end
end
