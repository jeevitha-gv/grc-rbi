class RisksController < ApplicationController

  layout 'risk_layout'

  def index
    @risks = current_company.risks
  end

  def new
    @risk = Risk.new
  end

  def create
    @risk = current_company.risks.build(risk_params)
  end

  def compliance_libraries
    @compliance_libraries = ComplianceLibrary.for_id_and_leaf(params[:compliance_id])
  end

  def department_teams_users
    risk_initializers(params[:location_id], params[:department_id], params[:team_id])
  end

  protected

    def risk_initializers(location_id = nil, department_id = nil, team_id = nil)
      @departments = Department.for_location(location_id) if location_id
      @teams = Team.for_department_and_company(department_id, current_company.id, 2) if department_id
      @team = Team.for_id(team_id).last if team_id
    end

  private

    def risk_params
      params.require(:risk).permit(:subject, :control_number, :reference, :compliance_id, :location_id, :category_id, :team_id, :technology_id, :owner)
    end

end
