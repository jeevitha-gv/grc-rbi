class AuditsController < ApplicationController
  load_and_authorize_resource :except => [:department_teams_users, :audit_with_status, :audit_all]
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
    audit_intializers(@audit.location_id, @audit.department_id, @audit.team_id)
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
      audit_intializers(@audit.location_id, @audit.department_id, @audit.team_id)
      render 'new'
    end
  end

  # Show audit and render to pdf
  def show
    @audit = current_audit
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
      audit_intializers(@audit.location_id, @audit.department_id, @audit.team_id)
      render 'edit'
    end
  end

  # list audits based on status for current user
  def audit_with_status
     @audits = current_user.accessible_audits.select{|x| x.audit_status_id == params[:audit_status_id].to_i}
  end

  # List all audits for current user
  def audit_all
   @audits = current_user.accessible_audits
  end

  #audit intializer data
  def department_teams_users
    audit_intializers(params[:location_id], params[:department_id], params[:team_id])
    render 'department_locations_list'
  end

  # Import audit from csv list
  def import_files
    if(params[:file].present?)
      begin
        spreadsheet = Audit.open_spreadsheet(params[:file])
        start = 2
        (start..spreadsheet.last_row).each do |i|
          row_data = spreadsheet.row(i)[0].split(";")
          set = 1
          auditee_array = []
          while set < 50
            auditee_check = spreadsheet.row(i)[set]
            auditee_array << auditee_check if auditee_check.present?
            break if auditee_check.blank?
            set += 1
          end

          auditee_array << row_data[17]
          audit_type = AuditType.where("lower(name) = ?", "#{row_data[7].to_s.strip.downcase}").first

          if row_data[8].strip.downcase=="compliance"
            comp_type = "Compliance"
            stand_id = Compliance.where("lower(name) = ?", row_data[9].to_s.downcase).first
          elsif row_data[8].strip.downcase=="noncompliance"
            comp_type = "NonCompliance"
            stand_id = Topic.where("lower(name) = ?", row_data[10].to_s.downcase).first
          end

          location = Location.where("lower(name)=? and company_id=?", "#{row_data[11].to_s.strip.downcase}",current_company.id).first
          department = Department.where("lower(name) = ? and location_id=?", "#{row_data[12].to_s.strip.downcase}",location.id).first if location.present?
          team = Team.where("lower(name) = ? and department_id=?", "#{row_data[13].to_s.strip.downcase}",department.id).first if department.present?

          auditor_user = User.where("lower(email) = ?", "#{row_data[16].to_s.strip.downcase}").first
          user_email = auditee_array.collect{|x| x.strip if x.present?}
          auditee_users = User.where(:email => user_email)

          audit = Audit.new
          audit.attributes ={:title => row_data[0],
            :scope => row_data[1],
            :objective => row_data[2],
            :issue => row_data[3],
            :methodology => row_data[4],
            :deliverables => row_data[5],
            :context => row_data[6],
            :audit_type_id => audit_type.present? ? audit_type.id : nil,
            :compliance_type => comp_type,
            :standard_id =>  stand_id.present? ? stand_id.id : nil,
            :location_id =>  location.present? ? location.id : nil,
            :department_id =>  department.present? ? department.id : nil,
            :team_id =>  team.present? ? team.id : nil,
            :start_date =>  row_data[14],
            :end_date =>  row_data[15],
            :auditor => auditor_user.present? ? auditor_user.id : nil,
            :company_id => current_company.id,
            :audit_status_id => AuditStatus.where(:name=>"Initiated").first.id
          }
          audit.save(:validate => false)
          auditee_users.map(&:id).collect{|x| audit.audit_auditees.create(:user_id =>x) }
        end
        redirect_to audits_path, notice: "Audit imported."
      rescue
        flash[:error]=  "Invalid file format"
        redirect_to new_audit_path
      end
    else
      flash[:error] = "Please select a file."
      redirect_to new_audit_path
    end
  end

  # download sample audit 
  def export_files
    audit_csv = CSV.generate do |csv|
      csv << ["title;scope;objective;issue;methodology;deliverables;context;audit_type;compliance_type;standard;topic;location;department;team;start_date;end_date;auditor;auditees"]
      csv << ["Example audit;how the csv data to be filled;data filled correctly;error if data entered wrongly;by csv;csv upload for audit;ensure the row csv;Internal Audit;NonCompliance;COBIT;System Security;chennai;devlopment;test_team;YYYY/mm/dd;YYYY/mm/dd;audit@example.com;auditee2@example.com", "auditee1@example.com"]
    end
    send_data(audit_csv, :type => 'text/csv', :filename => 'sample_audit.csv')
  end


  def asc_calculation
    audit = current_audit
    status_id = AuditStatus.where('name= ?','Published').first.id
    unless audit.audit_status_id == status_id
      audit.update(audit_status_id: status_id)
      audit.audit_operational_weightage(current_company)
    end
    redirect_to "/audits/audit_dashboard"
  end

  def audit_dashboard
      @audit = current_audit
    unless @audit.nil?
      @audit_domains, @audit_weightage, @audit_maximum_score , @audit_percentage= @audit.maximum_actual_score
      @to_do_list = @audit.compliance_checklist_recommendations
      @audit_users = @audit.audit_users
      @checklist_completed_count, @checklist_pending_count, @recommendation_completed_count, @recommendation_pending_count, @observation_completed_count, @observation_pending_count,@response_completed_count, @response_pending_count = @audit.audit_status_records
    end
  end

  def artifacts_download
		@audit = current_audit
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
    def audit_intializers(location_id=nil, department_id=nil, team_id=nil)
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
