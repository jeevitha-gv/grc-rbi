class AuditsController < ApplicationController
  before_action :authenticate_user!
  before_filter :check_company_disabled
  before_filter :audit_auditee_users, :only => [:new, :create]

  def index

  end


  def departments_list
    @departments = Department.where(:location_id=>params[:location_id]).all
    render :partial => 'department_locations_list'
  end

  def teams_list
    @teams = Team.where(:department_id=>params[:department_id])
    render :partial => 'department_locations_list'
  end

  def new
    @audit = Audit.new
  end

  def create
    @audit = Audit.new(audit_params)

    if @audit.save
      redirect_to new_audit_path
    else
      render 'new'
    end
  end


  private
    def audit_params
      params.require(:audit).permit(:title, :objective, :deliverables, :context, :issue, :scope, :methodology, :client_id, :audit_type_id, :compliance_type, :standard_id, :department_id, :team_id, :location_id, :auditor, audit_auditees_attributes: [:user_id])
    end

    def current_company_disabled
      if Company.find(current_user.company_id).is_disabled == true
        sign_out :user
        redirect_to new_user_session_path
      end
    end

    def audit_auditee_users
      # for users with role auditor
      @auditor_role = Role.where(:title=>"auditor", :company_id=>current_company.id).last
      @auditor_users = User.where(:role_id=>@auditor_role.id)
      # for users with role auditee
      @auditee_role = Role.where(:title=>"auditee", :company_id=>current_company.id).last
      @auditee_users = User.where(:role_id=>@auditee_role.id)
    end
end
