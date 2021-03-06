class ControlApprovalsController < ApplicationController
 before_filter :current_control
 before_filter :check_company_disabled, :company_module_access_check
 layout 'control_layout'
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

def update
    if @control.update(control_approval_params)
      flash[:notice] = "Approval Updated"
      # @control.update(control_status_id: IncidentStatus.where("name= ?", "New").first.id )
      redirect_to edit_control_control_approval_path(control_id: @control.id, id: @control.control_approval.id)
    else
      render "edit"
    end
  end
private
	
  def control_approval_params
   		params.require(:control).permit( control_approval_attributes:[ :id, :control_id, :comments]) 
	end
end