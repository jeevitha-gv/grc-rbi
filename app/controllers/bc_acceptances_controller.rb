class BcAcceptancesController < ApplicationController

  before_filter :current_bc
  before_filter :accessible_plans, :only => [:index]
  before_filter :authorize_bcaccpetance, :only => [:new, :create, :update, :edit] 

  layout 'bcm_layout'
  
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
      @bc_analysis.bc_status_id = 4
      @bc_analysis.save   
  		redirect_to bc_analyses_path
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
  		redirect_to bc_analyses_path
  	else
  		render new
  	end
  end

  private

  def bc_accep_params
  	params.require(:bc_acceptance).permit(:test_type_id, :scope, :test_goal, :test_objective)
  end

  def authorize_bcaccpetance
    if(current_user.role_title != "Bcm Owner" && current_user.role_title != "Bcm Manager"&& current_user.role_title != "company_admin")
      flash[:alert] = "Access Restricted"
      redirect_to bc_analyses_path
  end
  end

end
