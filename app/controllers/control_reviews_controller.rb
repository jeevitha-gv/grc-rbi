class ControlReviewsController < ApplicationController
before_filter :check_company_disabled, :company_module_access_check
 before_filter :current_control
 layout 'control_layout'
	def index
  	#@evaluates = current_user.evaluates
  end

def new
    if(@control.control_review.present?)
      redirect_to edit_control_control_review_path(control_id: @control.id, id: @control.control_review.id)
    else
      @control.build_control_review
    end
  end



  def create
    
   if @control.update(control_review_params) 
    flash[:notice] = "Review saved Successfully" 
    redirect_to edit_control_control_review_path(control_id: @control.id, id: @control.control_review.id)
  else
     flash[:notice] = "Control Review not  saved" 
    render new
  end
	end

def update
  if @control.update(control_review_params)
    flash[:notice] = "Review Updated"
    # @control.update(control_status_id: IncidentStatus.where("name= ?", "In-Progress").first.id )
    redirect_to edit_control_control_review_path(control_id: @control.id, id: @control.control_review.id)
  else
    render "edit"
  end
end

  def edit
    redirect_to new_control_control_review_path(control_id: @control.id) unless @control.control_review.present?
  end

private

	def control_review_params
   		params.require(:control).permit( control_review_attributes:[ :id, :control_id, :control_review_id,:control_approval_id, :fraud_related_id, :execution_steps, :expected_result]) 
	end
end



