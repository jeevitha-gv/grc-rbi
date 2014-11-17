class BcAcceptancesController < ApplicationController

  before_filter :current_bc
  before_filter :accessible_plans, :only => [:index]
  
  def index
  end

  def new
  	@bc_accep = @bc_analysis.bc_acceptance.present? ? @bc_analysis.bc_acceptance : @bc_analysis.build_bc_acceptance
  	@bc_impl = @bc_analysis.bc_implementation
    @bc_plan = @bc_analysis.bc_plan
  
  end
	
  def create
  	@bc_accep = @bc_analysis.build_bc_acceptance(bc_accep_params)
  	if @bc_accep.save
  		redirect_to bc_analysis_bc_acceptances_path
  	else
  		render new
  	end
  end  

  def edit
  	@bc_accep = @bc_analysis.build_bc_acceptance(bc_analysis: @bc_analysis_id)
  end

  def update
  	@bc_accep = @bc_analysis.bc_acceptance
  	if @bc_accep.update_attributes(bc_accep_params)
  		redirect_to bc_analysis_bc_acceptances_path
  	else
  		render new
  	end
  end

  private

  def bc_accep_params
  	params.require(:bc_acceptance).permit(:test_type_id, :scope, :test_goal, :test_objective)
  end

end
