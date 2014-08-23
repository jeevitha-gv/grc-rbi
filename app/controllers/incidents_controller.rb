class IncidentsController < ApplicationController
layout 'incident_layout'
  

  def index
    @incident = Incident.all
  end

  def new
    @incident = Incident.new
  end

  def edit
    @incident = Incident.find(params[:id])
    incident_initializers( @incident.department_id, @incident.team_id, @incident.request_type_id, @incident.incident_category_id, @incident.sub_category_id, @incident.incident_status_id, @incident.resolution_id)
  end

  def create
    @incident = Incident.create(incident_params)
    @incident.set_incident_status(@incident, params[:commit])

    if @incident.save
      flash[:notice] = "The incident was successfully created"
      redirect_to incidents_path
    else
      
      redirect_to new_incident_path
    end
  end
  
  def update
    @incident = Incident.find(params[:id])
    @incident.set_incident_status(@incident, params[:commit]) if params[:commit] == "Initiate incident"
    if @incident.update_attributes(incident_params)
      redirect_to edit_incident_path
    else
      incident_initializers( @incident.department_id, @incident.team_id, @incident.request_type_id,@incident.incident_status_id,@incident.sub_category_id,@incident.resolution_id)
      render 'edit'
    end
  end

def incident_all
    if params[:stage].present?
      @incidents = current_user.incidents_stage(params)
    else
      @incidents = current_user.accessible_incidents
    end
  end

  def download_incident_document
    attachment = Attachment.find(params[:id])
    send_file(Rails.public_path.to_s + attachment.attachment_file_url)
  end


  def remove_attachment
    attachment = Attachment.find(params[:id])
    attachment.delete
  end
  
  def show
      @incident = Incident.find(params[:id])
      # @incident=Evaluate.find(params[:id])
      respond_to do |format|
      format.html
      format.pdf do
      @pdf = (render_to_string pdf: "PDF", template: "incidents/show.pdf.erb", layout: 'layouts/pdf.html.erb', encoding: "UTF-8")
        send_data(@pdf, type: "application/pdf", filename: @incident.title)
      end
    end
  end
 
  def incident_dashboard
    @incident = Incident.all
     @inci= Incident.find_by_sql("SELECT count(*) FROM incidents ")

    @category_1= Incident.find_by_sql("SELECT count(*) FROM incidents where incident_category_id=1")
    @category_2= Incident.find_by_sql("SELECT count(*) FROM incidents where incident_category_id=2")
    @category_3= Incident.find_by_sql("SELECT count(*) FROM incidents where incident_category_id=3")
    @category_4= Incident.find_by_sql("SELECT count(*) FROM incidents where incident_category_id=4")
    @category_5= Incident.find_by_sql("SELECT count(*) FROM incidents where incident_category_id=5")
    @category_6= Incident.find_by_sql("SELECT count(*) FROM incidents where incident_category_id=6")
    @category_7= Incident.find_by_sql("SELECT count(*) FROM incidents where incident_category_id=7")
    @category_8= Incident.find_by_sql("SELECT count(*) FROM incidents where incident_category_id=8")
    
    @priority_1= Incident.find_by_sql("select count(*) from evaluates where incident_priority_id=1")
    @priority_2= Incident.find_by_sql("select count(*) from evaluates where incident_priority_id=2")
    @priority_3= Incident.find_by_sql("select count(*) from evaluates where incident_priority_id=3")
     



 # @inci= Incident.find_by_sql("SELECT count(*) FROM incidents where date_trunc('month', created_at), date_trunc('month', created_at)+'1month'::interval-'1day'::interval")
 
# @inci= Incident.find_by_sql("SELECT count(*) FROM incidents GROUB_BY created_at ")

  end

private
  
  def incident_params
    params.require(:incident).permit(:Jobtitle, :title, :request_type_id, :incident_category_id, :sub_category_id, :date_occured, :summary,:department_id, :team_id, :incident_status_id, :comment, :contact_no, attachment_attributes: [:id, :attachment_file, :company_id])
  end


  def incident_initializers(department_id = nil, team_id = nil,incident_status_id = nil, incident_category_id = nil,sub_category_id = nil, request_type_id = nil,resolution_id = nil )
    #@compliance_libraries = ComplianceLibrary.for_id_and_leaf(compliance_id) if compliance_id
    #@departments = Department.for_location(location_id) if location_id
    # section = Section.by_name('risk').first
    #@teams = Team.for_department_and_company(department_id, current_company.id, section.id) if department_id
    #@team_users = Team.for_id(team_id).first.users << current_company.company_admin if team_id
  end
  
end

 
