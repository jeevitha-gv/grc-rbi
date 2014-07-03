class RisksController < ApplicationController
  before_filter :risk_users

  layout 'risk_layout'

  def index
    @risks = current_company.risks
    @high_risk, @medium_risk, @low_risk = Risk.risk_rating(current_company.id)
  end

  def new
    @risk = Risk.new
  end

  def create
    @risk = current_company.risks.build(risk_params)
    @risk.submitted_by = current_user.id
    if @risk.save
      redirect_to risks_path, :flash => { :notice => MESSAGES["risk"]["create"]["success"]}
    else
      risk_initializers(@risk.location_id, @risk.department_id, @risk.team_id, @risk.compliance_id)
      render 'new'
    end
  end

  def risk_imports
  end

  def risk_export
  end

  def department_teams_users
    risk_initializers(params[:location_id], params[:department_id], params[:team_id], params[:compliance_id])
  end

  protected
    def risk_initializers(location_id = nil, department_id = nil, team_id = nil, compliance_id = nil)
      @compliance_libraries = ComplianceLibrary.for_id_and_leaf(compliance_id) if compliance_id
      @departments = Department.for_location(location_id) if location_id
      @teams = Team.for_department_and_company(department_id, current_company.id, 2) if department_id
      @team_users = Team.for_id(team_id).first.users if team_id
    end

  private
    def risk_params
      params.require(:risk).permit(:subject, :control_number, :reference, :compliance_id, :location_id, :category_id, :team_id, :technology_id, :owner, :assessment, :notes, :compliance_library_id, :department_id, :mitigator, :reviewer)
    end

    def risk_users
      @mitigator_role = Role.for_title("mitigator").first
      @mitigator_users = current_company.users.where(role_id: @mitigator_role.id)

      @reviewer_role = Role.for_title("reviewer").first
      @reviewer_users = current_company.users.where(role_id: @reviewer_role.id)
    end
end
