class ResolutionsController < ApplicationController
  def index
  	#@resolutions = current_user.resolutions
  end

def new
    #@evaluate = @incident.evaluate.present? ? @incident.evaluate : @incident.build_evaluate
     @incident = Incident.first
   # @evaluate = @incident.evaluate.present? ? @incident.evaluate : @incident.build_evaluate
   @incident.build_resolution
  end

  def create
    # if @incident.update(evaluate_params)
   #    flash[:notice] = "Evaluation saved" 
   #    redirect_to edit_incident_evaluate_path(incident_id: @incident.id, id: @incident.evaluate.id)
   #  else
   #    render "new"
   #  end 
    @resolution = Resolution.first
   @resolution = @incident.build_resolution(resolution_params)
   if @resolution.save
    render "new"
    #redirect_to edit_incident_evaluate_path(incident_id: @incident.id, id: @incident.evaluate.id)
  else
    render new
  end
  end

  


  private
   
   def resolution_params
   # params.require(:incident).permit( evaluates_attributes:[:id, :incident_id, :urgency_id, :incident_priority_id,:incident_impact_id,:assignee,:target_date,:sla_id,:incident_origin_id,:resolutiontime,:escalation_id])
    #params.require(:incident,:evaluate).permit(:id,:Jobtitle,:title,:request_type_id,:incident_category_id,:sub_category_id,:date_occured,:summary,:department_id,:team_id,:incident_status_id,:comment,:contact_no,:incident_id, :title,:Jobtitle,:urgency_id, :incident_priority_id,:incident_impact_id,:assignee,:target_date,:sla_id,:incident_origin_id,:resolutiontime,:escalation_id ,resolutions_attributes: [:evaluate_id,:incident_id,:reassignee,:solution_type_id,:solution,:rootcause,:closure_classification_id]) 
    params.require(:incident).permit(resolutions_attributes:[:id,:Jobtitle,:title,:request_type_id,:incident_category_id,:sub_category_id,:date_occured,:summary,:department_id,:team_id,:incident_status_id,:comment,:contact_no,:evaluate_id,:incident_id,:reassignee,:solution_type_id,:solution,:rootcause,:closure_classification_id])
end
end