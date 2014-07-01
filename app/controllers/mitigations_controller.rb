class MitigationsController < ApplicationController

  def index
  end

  def new
   @mitigation = Mitigation.new
   @risk = Risk.first

   @risk.build_mitigation
   @risk.control_measures.build
   @controls =  CppMeasure.where("company_id= ? AND measure_type = ?",current_company.id,'Control')
   @process = CppMeasure.where("company_id= ? AND measure_type = ?",current_company.id,'Process')
   @procedure = CppMeasure.where("company_id= ? AND measure_type = ?",current_company.id,'Procedure')
  end

  def create
    @mitigation = Mitigation.new(mitigation_params)

  end

private

 def mitigation_params
   params.require(:risk).permit(mitigation_attributes: [:risk_id, :planning_strategy_id, :mitigation_effort_id, :current_solution, :security_requirements, :security_recommendations, :submitted_by, :id, control_measures_attributes: [ :id, :risk_id, :control_ids, :threat, :consequences, :effectiveness, :risk_scoring_id, :process_ids, :procedure_ids]])
 end

end
