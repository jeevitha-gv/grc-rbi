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
  binding.pry
   @incident = Incident.first
   @evaluate = @incident.build_evaluate(evaluate_params)
   if @evaluate.save
    redirect_to edit_incident_evaluate_path(incident_id: @incident.id, id: @incident.evaluate.id)
  else
    render new
  end
	end

  def edit
  end


  private
   
   def evaluate_params
   # params.require(:incident).permit( evaluates_attributes:[:id, :incident_id, :urgency_id, :incident_priority_id,:incident_impact_id,:assignee,:target_date,:sla_id,:incident_origin_id,:resolutiontime,:escalation_id])
    params.require(:incident).permit(:id, evaluates_attributes: [:id, :incident_id, :title,:Jobtitle,:urgency_id, :incident_priority_id,:incident_impact_id,:assignee,:target_date,:sla_id,:incident_origin_id,:resolutiontime,:escalation_id]) 
end
end
