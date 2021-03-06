class BcImplementationsController < ApplicationController

  before_filter :current_bc
  before_filter :accessible_plans, :only => [:index]
  before_filter :authorize_bcimpl, :only => [:new, :create, :update, :edit] 
  
  layout 'bcm_layout'

  def index

  end

  def new
  	@bc_impl = @bc_analysis.bc_implementation.present? ? @bc_analysis.bc_implementation : @bc_analysis.build_bc_implementation
  	@bc_plan  = @bc_analysis.bc_plan
  end

  def create
  	@bc_impl = @bc_analysis.build_bc_implementation(bc_impl_params)
  	if @bc_impl.save
      @bc_analysis.bc_status_id = 3
      @bc_analysis.save  		
  		redirect_to bc_analyses_path
  	else
  		render new
  	end
  end 

  def edit
  	@bc_impl = @bc_analysis.bc_implementation(bc_analysis: @bc_analysis_id)
  end

  def update
    @bc_impl = @bc_analysis.bc_implementation
    if @bc_impl.update_attributes(bc_impl_params)
      redirect_to bc_analyses_path
    else 
      render new
    end
  end

  private
  def bc_impl_params
  	params.require(:bc_implementation).permit(:implementation_status_id, :impl_actions)
  end

  def authorize_bcimpl
    if(current_user.role_title != "Bcm Manager" && current_user.role_title != "company_admin")
      flash[:alert] = "Access Restricted"
      redirect_to bc_analyses_path
  end
  end
  
end
