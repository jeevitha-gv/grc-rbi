class EvaluatesController < ApplicationController
  def index
  	#@evaluates = current_user.evaluates
  end

def new
    #@evaluate = @incident.evaluate.present? ? @incident.evaluate : @incident.build_evaluate
    
    @incident = Incident.first
   # @evaluate = @incident.evaluate.present? ? @incident.evaluate : @incident.build_evaluate
   @incident.build_evaluate
  end

  def create
  	# if @incident.update(evaluate_params)
   #    flash[:notice] = "Evaluation saved" 
   #    redirect_to edit_incident_evaluate_path(incident_id: @incident.id, id: @incident.evaluate.id)
   #  else
   #    render "new"
   #  end

    @incident = Incident.first
   @evaluate = @incident.build_evaluate(evaluate_params)
   if @evaluate.save
    render "new"
    #redirect_to edit_incident_evaluate_path(incident_id: @incident.id, id: @incident.evaluate.id)
  else
    render new
  end
	end






  def edit
  end
  
  def update
      if @incident.(evaluate_params)
      redirect_to edit_incident_evaluate_path(incident_id: @incident.id, id: @incident.evaluate.id)
    else
      render "edit"
    end
  end

  private
   
   def evaluate_params
   # params.require(:incident).permit( evaluates_attributes:[:id, :incident_id, :urgency_id, :incident_priority_id,:incident_impact_id,:assignee,:target_date,:sla_id,:incident_origin_id,:resolutiontime,:escalation_id])
    params.require(:incident).permit(:id,:Jobtitle,:title,:request_type_id,:incident_category_id,:sub_category_id,:date_occured,:summary,:department_id,:team_id,:incident_status_id,:comment,:contact_no ,evaluates_attributes: [:incident_id, :title,:Jobtitle,:urgency_id, :incident_priority_id,:incident_impact_id,:assignee,:target_date,:sla_id,:incident_origin_id,:resolutiontime,:escalation_id]) 
    
end
end
