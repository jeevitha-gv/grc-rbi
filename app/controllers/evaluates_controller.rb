class EvaluatesController < ApplicationController

  before_filter :current_incident
  before_filter :authorize_evaluate, :only => [:new, :create, :edit, :update]

  layout 'incident_layout'
  def index
  	#@evaluates = current_user.evaluates
  end

def new
    if(@incident.evaluate.present?)
      redirect_to edit_incident_evaluate_path(incident_id: @incident.id, id: @incident.evaluate.id)
    else
      @incident.build_evaluate
    end
  end



  def create
    
   if @incident.update(evaluate_params) 
    flash[:notice] = "Evaluation saved" 
    redirect_to edit_incident_evaluate_path(incident_id: @incident.id, id: @incident.evaluate.id)
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



  def edits
    redirect_to new_incident_evaluate_path(incident_id: @incident.id) unless @incident.evaluate.present?
  end

def update
    if @incident.update(evaluate_params)
      flash[:notice] = "Evaluation Updated"
      @incident.update(incident_status_id: IncidentStatus.where("name= ?", "New").first.id )
      redirect_to edit_incident_evaluate_path(incident_id: @incident.id, id: @incident.evaluate.id)
    else
      render "edit"
    end
  end


  private
   
   def evaluate_params
   params.require(:incident).permit( evaluate_attributes:[ :id, :incident_id, :urgency_id, :incident_priority_id,:incident_impact_id, :assignee,:target_date,:sla_id,:incident_origin_id,:resolutiontime,:escalation_id]) 
end

def authorize_evaluate
    if (current_user.role_title != "Incidentmanager") 
      flash[:alert] = "Access restricted"
      redirect_to incidents_path
    end
  end
end