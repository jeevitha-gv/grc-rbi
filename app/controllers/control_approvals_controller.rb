class ControlApprovalsController < ApplicationController
 before_filter :current_control
	def index
  	#@evaluates = current_user.evaluates
  end

def new
    if(@control.control_approval.present?)
      redirect_to edit_control_control_approval_path(control_id: @control.id, id: @control.control_approval.id)
    else
      @control.build_control_approval
    end
  end



  def create
    
   if @control.update(control_approval_params) 
    flash[:notice] = "Approval saved Successfully" 
    redirect_to edit_control_control_approval_path(control_id: @control.id, id: @control.control_approval.id)
  else
     flash[:notice] = "Control Approval not  saved" 
    render new
  end
	end

  def edit
  redirect_to new_control_control_approval_path(control_id: @control.id) unless @control.control_approval.present?
end

private
	
  def control_approval_params
   		params.require(:control).permit( control_approval_attributes:[ :id, :control_id, :comments]) 
	end
end
