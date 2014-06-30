class RisksController < ApplicationController

  def index
    @risks = current_company.risks
  end

  def new
    @risk = Risk.new
  end

  def create
    @risk = current_company.risks.build(risk_params)
  end

  private

  def risk_params
    params.require(:risk).permit(:subject, :control_number, :reference, :compliance_id, :location_id, :category_id, :team_id, :technology_id, :owner)
  end

end
