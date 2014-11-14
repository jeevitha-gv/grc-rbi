class ControlAuditsController < ApplicationController

	before_filter :current_control
	def index
  	#@evaluates = current_user.evaluates
  end

def new
    if(@control.control_audit.present?)
      redirect_to edit_control_control_audit_path(control_id: @control.id, id: @control.control_audit.id)
    else
      @control.build_control_audit
    end
  end



  def create
    
   if @control.update(control_audit_params) 
    flash[:notice] = "Evaluation saved" 
    redirect_to edit_control_control_audit_path(control_id: @control.id, id: @control.control_audit.id)
  else
     flash[:notice] = "Evaluation not  saved" 
    render new
  end
	end

  def edit
  redirect_to new_control_control_audit_path(control_id: @control.id) unless @control.control_audit.present?
end

private

	def control_audit_params
   		params.require(:control).permit( control_audit_attributes:[ :id, :control_id, :control_approval_id, :control_review_id, :control_audit_id, :audit_metric_description, :audit_success_criteria]) 
	end

end
