class IncidentsController < ApplicationController
layout 'incident_layout'
   def index
  @incidents = Incident.all



  end

  def new
    @incident = Incident.new
  end

  def create
    @incident = Incident.new(incident_params)
    
    if @incident.save
      flash[:notice] = "The incident was successfully created"
      redirect_to new_incident_path
    else
      
      redirect_to risks_path
    end
  end


   def download_incident_document
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


  private
    def incident_params
      params.require(:incident).permit(:Jobtitle, :title, :request_type_id, :incident_category_id, :sub_category_id, :date_occured, :summary, :department_id, :team_id, :incident_status_id, :comment, :contact_no, attachment_attributes: [:id, :attachment_file, :company_id])
    end
end
