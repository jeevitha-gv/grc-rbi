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
     redirect_to edit_incident_resolution_path(incident_id: @incident.id, id: @incident.resolution.id)
  else
    flash[:notice] = "Resolution not  saved" 
    render new
  end
end

def download_resolution_document
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
  redirect_to new_incident_resolution_path(incident_id: @incident.id) unless @incident.resolution.present?
end
  
def update
  if @incident.update(resolution_params)
    flash[:notice] = "Resolution Updated"
    @incident.update(incident_status_id: IncidentStatus.where("name= ?", "In-Progress").first.id )
    redirect_to edit_incident_resolution_path(incident_id: @incident.id, id: @incident.resolution.id)
  else
    render "edit"
  end
end

private

  def resolution_params
   params.require(:incident).permit( resolution_attributes:[:id, :evaluate_id,:incident_id, :reassignee, :solution_type_id,:solution, :rootcause,:closure_classification_id, attachment_attributes: [:id, :attachment_file, :company_id]]) 
  end
end

