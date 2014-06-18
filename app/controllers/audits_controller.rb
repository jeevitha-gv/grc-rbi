class AuditsController < ApplicationController
  # load_and_authorize_resource :except => [:department_teams_users, :audit_with_status, :audit_all]
  # before_filter :authorize_audit, :only => [:edit, :update]
  before_filter :check_company_disabled
  before_filter :audit_auditor_users, :only => [:new, :create, :edit, :update]

  def index

  end

  def new
    @audit = Audit.new
    @audit.build_skipped_audit_reminder
  end

  def edit
    @audit = Audit.find_by_id(params[:id])
    @departments = Department.where(:location_id=>@audit.location_id) if @audit.location_id
    @teams = Team.where(:department_id=>@audit.department_id) if @audit.department_id
    @team = Team.where(:id=>@audit.team_id).last if @audit.location_id
  end

  def create
    @audit = Audit.new(audit_params)
    @audit.company_id = current_company.id
    if params[:commit] == "Save as Plan"
      @audit.audit_status_id=AuditStatus.where(:name=>"Planning").first.id
    else
      @audit.audit_status_id=AuditStatus.where(:name=>"In Progress").first.id
    end

    if @audit.save
      cookies[:audit_id] = { :value => @audit.id, :expires => 24.hour.from_now }
      if params[:skip_reminder] == "true"
        SkippedAuditReminder.create(:audit_id => @audit.id,:skipped_by => current_user.id)
      end
      UniversalMailer.delay.notify_auditor_about_audit(@audit)
      UniversalMailer.delay.notify_auditees_about_audit(@audit)
      redirect_to audits_path
    else
      @departments = Department.where(:location_id=>@audit.location_id) if @audit.location_id
      @teams = Team.where(:department_id=>@audit.department_id) if @audit.department_id
      @team = Team.where(:id=>@audit.team_id).last if @audit.team_id
      render 'new'
    end
  end

  def show
    @audit = current_audit
    respond_to do |format|
      format.html
      format.pdf do
        #~ render :pdf => "pdf", :template => "audits/show.pdf.erb", layout: 'layouts/pdf.html.erb'
         @pdf = render_to_string :pdf => "pdf", :template => "audits/show.pdf.erb", layout: 'layouts/pdf.html.erb',
            :encoding => "UTF-8"
        send_data(@pdf,   :type=>"application/pdf")
      end
    end
  end


  def update
    @audit = Audit.find_by_id(params[:id])

    if @audit.update_attributes(audit_params)
      cookies[:audit_id] = { :value => @audit.id, :expires => 24.hour.from_now }
      redirect_to edit_audit_path
    else
      @departments = Department.where(:location_id=>@audit.location_id) if @audit.location_id
      @teams = Team.where(:department_id=>@audit.department_id) if @audit.department_id
      @team = Team.where(:id=>@audit.team_id).last if @audit.location_id
      render 'edit'
    end
  end

  def audit_with_status
     @audits = current_user.accessible_audits.select{|x| x.audit_status_id==params[:audit_status_id].to_i}
  end

  def audit_all
   @audits = current_user.accessible_audits
  end

  def department_teams_users
    @departments = Department.where(:location_id=>params[:location_id]) if params[:location_id]
    @teams = Team.where(:department_id=>params[:department_id]) if params[:department_id]
    @team = Team.where(:id=>params[:team_id]).last if params[:team_id]
    render 'department_locations_list'
  end

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
          audit_type = AuditType.where("lower(name) = ?", "#{row_data[7].to_s.downcase}").first

          if row_data[8].downcase=="compliance"
            comp_type = "Compliance"
            stand_id = Compliance.where("lower(name) = ?", row_data[9].to_s.downcase).first
          elsif row_data[8].downcase=="noncompliance"
            comp_type = "NonCompliance"
            stand_id = Topic.where("lower(name) = ?", row_data[10].to_s.downcase).first
          end

          location = Location.where("lower(name)=? and company_id=?", "#{row_data[11].to_s.downcase}",current_company.id).first
          department = Department.where("lower(name) = ? and location_id=?", "#{row_data[12].to_s.downcase}",location.id).first if location.present?
          team = Team.where("lower(name) = ? and department_id=?", "#{row_data[13].to_s.downcase}",department.id).first if department.present?

          auditor_user = User.where("lower(email) = ?", "#{row_data[16].to_s.downcase}").last
          user_role = auditor_user.role.title == "auditor" if auditor_user.present?
          auditor = user_role == true ? auditor_user : nil
          user_email = auditee_array.collect{|x| x.strip if x.present?}
          auditee_role = Role.where(:title=>"auditee", :company_id=>current_company.id).last
          auditee_users = User.where("lower(email) IN (?) and role_id IN(?)", user_email, auditee_role)

          audit = new
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
            :auditor => auditor.present? ? auditor.id : nil,
            :company_id => current_company.id,
            :audit_status_id => AuditStatus.where(:name=>"Initiated").first.id
          }
          audit.save(:validate => false)
          auditee_users.map(&:id).collect{|x| audit.audit_auditees.create(:user_id =>x) }
        end
        redirect_to audits_path, notice: "Audit imported."
      rescue
        @errors = "Invalid file format"
        redirect_to new_audit_path
      end
    else
      @errors = "Please select a file."
      redirect_to new_audit_path
    end
  end

  def export_files
    audit_csv = CSV.generate do |csv|
      csv << ["title;scope;objective;issue;methodology;deliverables;context;audit_type;compliance_type;standard;topic;location;department;team;start_date;end_date;auditor;auditees"]
      csv << ["Example audit;how the csv data to be filled;data filled correctly;error if data entered wrongly;by csv;csv upload for audit;ensure the row csv;Internal Audit;NonCompliance;COBIT;System Security;chennai;devlopment;test_team;dd/mm/yy;dd/mm/yy;audit@example.com;auditee2@example.com", "auditee1@example.com"]
    end
    send_data(audit_csv, :type => 'text/csv', :filename => 'sample_audit.csv')
  end


  def asc_calculation
    audit = current_audit
    audit.update(audit_status_id: 4)
    Audit.audit_operational_weightage(current_company,audit)
    redirect_to particular_dashboard_audits_path
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

  private
    def audit_params
      params.require(:audit).permit(:title, :objective, :deliverables, :context, :issue, :scope, :methodology, :client_id, :audit_type_id, :audit_status_id, :compliance_type, :standard_id, :department_id, :team_id, :location_id, :auditor, :start_date, :end_date, audit_auditees_attributes: [:id, :user_id])
    end

    # def skipped_reminder_params
    #   params.require(:skipped_reminder).permit(:audit_id,:skipped_by)
    # end

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
