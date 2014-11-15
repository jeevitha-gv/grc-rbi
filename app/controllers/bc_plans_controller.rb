class BcPlansController < ApplicationController

	before_filter :current_bc
  before_filter :accessible_plans, :only => [:index]

  def index
  end

  def new
  	@bc_plan = @bc_analysis.bc_plan.present? ? @bc_analysis.bc_plan : @bc_analysis.build_bc_plan
  end

  def create
  	@bc_plan = @bc_analysis.build_bc_plan(bc_plan_params)
    @bc_plan.plan_status_id = 1
  	if @bc_plan.save
  		redirect_to bc_analysis_bc_plans_path
  	else
  		redirect_to new_bc_analysis_bc_plan_path
  	end
  end

  def edit
  	@bc_plan = @bc_analysis.bc_plan(bc_analysis: @bc_analysis_id)
  end

  def bc_plan_params
    params.require(:bc_plan).permit(:bc_analysis_id, :plan, :opex, :capex, :plan_responsible, :launch_responsible, :plan_status_id, :recurrence_id, :review_date, :objective, :audit_metric, :success_criteria,:launch_criteria)
  end

end
