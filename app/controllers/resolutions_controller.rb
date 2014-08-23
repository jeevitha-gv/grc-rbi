
class ResolutionsController < ApplicationController
  before_filter :current_incident
  layout 'incident_layout'
  def index
    #@evaluates = current_user.evaluates
  end

def new
    if(@incident.resolution.present?)
      redirect_to edit_incident_resolution_path(incident_id: @incident.id, id: @incident.resolution.id)
    else
      @incident.build_resolution
    end
  end

 def create
    
   if @incident.update(resolution_params) 
    flash[:notice] = "Resolution saved" 
    @incident.update(incident_status_id: IncidentStatus.where("name= ?", "Resolved").first.id )
    render "new"
    # redirect_to edit_incident_resolution_path(incident_id: @incident.id, id: @incident.resolution.id)
  else
     flash[:notice] = "Resolution not  saved" 
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
  
  def edit
    redirect_to new_incident_resolution_path(incident_id: @incident.id) unless @incident.resolution.present?
  end
  
def update
    if @incident.update(resolution_params)
      flash[:notice] = "mitigation saved"
      @incident.update(incident_status_id: IncidentStatus.where("name= ?", "In-Progress").first.id )
      redirect_to edit_incident_resolution_path(incident_id: @incident.id, id: @incident.resolution.id)
    else
      render "edit"
    end
  end

private
   
   def resolution_params
   params.require(:incident).permit( resolution_attributes:[ :evaluate_id,:incident_id, :reassignee, :solution_type_id,:solution, :rootcause,:closure_classification_id]) 
end
end

