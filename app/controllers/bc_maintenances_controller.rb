class BcMaintenancesController < ApplicationController

  before_filter :current_bc
  before_filter :accessible_plans, :only => [:index]

  layout 'bcm_layout'
  
  def index
  end

  def new
  @bc_main = @bc_analysis.bc_maintenance.present? ? @bc_analysis.bc_maintenance : @bc_analysis.build_bc_maintenance
  @bc_accep = @bc_analysis.bc_acceptance
  @bc_plan = @bc_analysis.bc_plan
  @bc_impl = @bc_analysis.bc_implementation
  end

  def create
  	@bc_main = @bc_analysis.build_bc_maintenance(bc_main_params)
  	if @bc_main.save
  		redirect_to bc_analysis_bc_maintenances_path
  	else
  		render new
  	end
  end

  def edit
  	@bc_main = @bc_analysis.build_bc_maintenance(bc_analysis: @bc_analysis_id)
  end

  def update
  	@bc_main = @bc_analysis.bc_maintenance
  	if @bc_main.update_attributes(bc_main_params)
  		redirect_to bc_analysis_bc_maintenances_path
  	else
  		render new
  	end
  end

  private

  def bc_main_params
  	params.require(:bc_maintenance).permit(:recurrence_id, :issues, :decision)
  end
end
