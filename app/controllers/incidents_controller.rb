class IncidentsController < ApplicationController
before_filter :authorize_incident, :only => [:new, :create, :update, :edit] 
 layout 'incident_layout'
 
   def index
    #binding.pry
    query = ""
    input_data = []
    if params[:title] && params[:title].present?
      query += "title = ? AND "
      input_data << params[:title]
    end
    if params[:category_id] && params[:category_id].present?
      query += "incident_category_id = ? AND "
      input_data << params[:category_id]      
    end
    if params[:request_type_id] && params[:request_type_id].present?
      query += "request_type_id = ? AND "
       input_data << params[:request_type_id]      
    end

    if params[:department_id] && params[:department_id].present?
      query += "department_id = ? AND "
       input_data << params[:department_id]      
    end
    if params[:team_id] && params[:team_id].present?
      query += "team_id = ? AND "
       input_data << params[:team_id]      
    end
    if input_data.length > 0 
      input_data.unshift(query.chomp(' AND '))
      input_data.flatten!
      @incident = Incident.where(input_data)
    else
      @incident = Incident.all
      
    end

    # respond_to do |format|
    #   format.html
    #   format.pdf do
    #   @pdf = (render_to_string pdf: "PDF", template: "incidents/index.pdf.erb", layout: 'layouts/pdf.html.erb', encoding: "UTF-8",locals: { incident: @incident},:disposition => 'attachment')
    #     #send_data(@pdf, type: "application/pdf", filename: @incident.title)
    #     send_data(@pdf, type: "application/pdf")
    #     binding.pry
    #   end
    # end
  end


    def generate_pdf
 
  end


  def import
if(params[:file].present?)
      
        Incident.import(params[:file], current_company)
        redirect_to incidents_path
      
      
    end

    
  end
  def export
    begin
      file_to_download = "sample_incident.csv"
      send_file Rails.public_path + file_to_download, :type => 'text/csv; charset=iso-8859-1; header=present', :disposition => "attachment; filename=#{file_to_download}", :stream => true, :buffer_size => 4096
    rescue
      redirect_to new_incident_path
    end
  end

  # def import
  #   Incident.import(params[:file])
  #   redirect_to incidents_path
  # end


  def new
    @incident = Incident.new
  end

  def edit
    @incident = Incident.find(params[:id])
    incident_initializers( @incident.department_id, @incident.team_id, @incident.request_type_id, @incident.incident_category_id, @incident.sub_category_id, @incident.incident_status_id, @incident.resolution_id)
  end

  def create
    @incident = Incident.create(incident_params)
    #@incident.set_incident_status(@incident, params[:commit])

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

  def download_resolution_document
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

#    def visitdata
#     # id = 0
#     # status = 0
#     #@nam= Control.joins(:standard).select("name").group(:name)
   
       
     
#      puts "------------------------------------------------------------"
#      puts status
#      if params[:stnd]  && params[:status]
#        @nam2 = Control.joins(:standard).joins(:control_state).where("compliances.name = ? and control_states.name =?",params[:stnd],params[:status]).select("title,control_states.name as sname,compliances.name as cname,count(standard_id) as count").group(:sname,:cname,:standard_id,:title).order('cname')
#  @data = {categories:@nam2.map(&:title), data: @nam2.map(&:count), cateory: params[:name]}
#  elsif params[:name]
#      @nam1 =  Control.joins(:standard).joins(:control_state).where("compliances.name = ?",params[:name]).select("control_states.name as sname,compliances.name as cname,count(standard_id) as count").group(:sname,:cname,:standard_id).order('cname')
#             #binding.pry
#    @data = {categories:@nam1.map(&:sname), data: @nam1.map(&:count), stnd: params[:name]}
#     # else
#     #   @data = {name: 'Tokyo', data: [49.9, 71.5, 106.4, 129.2, 144.0, 176.0, 135.6, 148.5, 216.4, 194.1, 95.6, 54.4], id: 1, status: 0}
# else
# # @nam =Control.joins(:standard).select("name,count(standard_id) as count").group(:name,:standard_id).order('name')
# @nam =Evaluate.select("COUNT(evaluates.id) AS count, evaluates.name").group(:name)

#       @data = {categories:@nam.map(&:name), data: @nam.map(&:count)}    
#      end
#     render :json =>@data
#   end

 
 
def incident_dashboard
@inci = Evaluate.find_by_sql("select incident_priorities.name,evaluates.incident_priority_id as id,count(incident_priority_id)as count FROM evaluates INNER JOIN incident_priorities ON incident_priorities.id = evaluates.incident_priority_id  GROUP BY incident_priority_id,incident_priorities.name")
@inci1=Incident.find_by_sql("select incident_categories.name as name,incident_priority_id as id,count(incident_category_id)as count FROM incident_categories INNER JOIN incidents ON incident_categories.id = incidents.incident_category_id  INNER JOIN evaluates ON evaluates.incident_id = incidents.id GROUP BY incident_category_id,incident_priority_id,name")
@cate = Incident.find_by_sql("select incident_categories.name as name,count(incident_category_id)as count FROM incidents INNER JOIN incident_categories ON incident_categories.id = incidents.incident_category_id  GROUP BY incident_category_id,name")
@stat=Incident.find_by_sql("select incident_statuses.name as name,count(incident_status_id)as count FROM incidents INNER JOIN incident_statuses ON incident_statuses.id = incidents.incident_status_id  GROUP BY incident_status_id,name")
@dept=Incident.find_by_sql("select departments.name as name,count(department_id)as count FROM incidents INNER JOIN departments ON departments.id = incidents.department_id  GROUP BY department_id,name")

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

  def authorize_incident
    if(current_user.role_title != "Incidentmanager" && current_user.role_title != "IncidentCreator" && current_user.role_title != "company_admin")
      flash[:alert] = "Access Restricted"
      redirect_to incidents_path
  end
end
   
                            
end

 
