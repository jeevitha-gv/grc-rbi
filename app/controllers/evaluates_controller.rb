class EvaluatesController < ApplicationController

  before_filter :current_incident

  layout 'incident_layout'
  def index
  	#@evaluates = current_user.evaluates
  end

# def new
#    @incident = Incident.first
#     # if(@incident.evaluate.present?)
#     #   redirect_to edit_incident_evaluate_path(incident_id: @incident.id, id: @incident.evaluate.id)
#     # else
#       @incident.build_evaluate
# end

def new
    if(@incident.evaluate.present?)
      redirect_to edit_incident_evaluate_path(incident_id: @incident.id, id: @incident.evaluate.id)
    else
      @incident.build_evaluate
    end
  end



  def create
    # @incident = Incident.first
   if @incident.update(evaluate_params) 
    flash[:notice] = "Evaluation saved" 
    render "new"
    #redirect_to edit_incident_evaluate_path(incident_id: @incident.id, id: @incident.evaluate.id)
  else
     flash[:notice] = "Evaluation not  saved" 
    render new
  end
	end


def download_evaluate_document
    attachment = Attachment.find(params[:id])
    send_file(Rails.public_path.to_s + attachment.attachment_file_url)
  end


    def download_document
      attachment = Attachment.find(params[:id])
      send_file(Rails.public_path.to_s + attachment.attachment_file_url)
    end

  def remove_attachment
    attachment = Attachment.find(params[:id])
    attachment.delete
  end



  def edit
    redirect_to new_incident_evaluate_path(incident_id: @incident.id) unless @incident.evaluate.present?
  end
  
  # def update
  #     if @incident.(evaluate_params)
  #     redirect_to edit_incident_evaluate_path(incident_id: @incident.id, id: @incident.evaluate.id)
  #   else
  #     render "edit"
  #   end
  # end

def update
    if @incident.update(evaluate_params)
       #@incident.incident_scoring.scoring.update(mitigation_params["scoring"])
      flash[:notice] = "mitigation saved"
      @incident.update(incident_status_id: IncidentStatus.where("name= ?", "In-Progress").first.id )
      redirect_to edit_incident_evaluate_path(incident_id: @incident.id, id: @incident.evaluate.id)
    else
      render "edit"
    end
  end





  private
   
   def evaluate_params
   params.require(:incident).permit( evaluate_attributes:[ :incident_id, :urgency_id, :incident_priority_id,:incident_impact_id, :assignee,:target_date,:sla_id,:incident_origin_id,:resolutiontime,:escalation_id]) 
end
end
