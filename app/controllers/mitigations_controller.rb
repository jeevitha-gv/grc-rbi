class MitigationsController < ApplicationController

  before_filter :current_risk

  def index
  end

  def new
   @mitigation = MitigationsController.new
   @risk.build_mitigation
   @risk.build_control_measure
   @controls =  CppMeasure.where("company_id= ? AND measure_type = ?",current_company.id,'Control')
   @process =   CppMeasure.where("company_id= ? AND measure_type = ?",current_company.id,'Process')
   @procedure = CppMeasure.where("company_id= ? AND measure_type = ?",current_company.id,'Procedure')
  end

  def create
    if @risk.update(mitigation_params)
      flash[:notice] = "mitigation saved"

    else
      render "new"
    end
  end

private

 def mitigation_params
   params.require(:risk).permit(mitigation_attributes:[ :planning_strategy_id, :mitigation_effort_id, :current_solution, :security_requirements, :security_recommendations, :submitted_by], control_measure_attributes: [ :id, :risk_id, :control_ids, :threat, :consequences, :effectiveness, :risk_scoring_id, :process_ids, :procedure_ids])
 end

end
