class ClosesController < ApplicationController
	before_filter :current_incident
	layout 'incident_layout'

def index

end

def new 
	if(@incident.close.present?)
		redirect_to edit_incident_close_path(incident_id: @incident.id, id: @incident.close.id)
	else
		@incident.build_close
	end
end

def create
	if @incident.update(close_params)
		flash[:notice] = "Closure Submitted Successfully"
		# @incident.update(incident_status_id: IncidentStatus.where("name = ?", "Resolved").first.id)
		redirect_to edit_incident_close_path(incident_id: @incident.id, id: @incident.close.id)
	else
		flash[:notice] = "Resolution not  saved" 
    	render new
    end
end

def edit
  redirect_to new_incident_close_path(incident_id: @incident.id) unless @incident.close.present?
end
  
def update
  if @incident.update(close_params)
    flash[:notice] = "close Updated"
    @incident.update(incident_status_id: IncidentStatus.where("name= ?", "In-Progress").first.id )
    redirect_to edit_incident_close_path(incident_id: @incident.id, id: @incident.close.id)
  else
    render "edit"
  end
end


private

def close_params
	params.require(:incident).permit(close_attributes: [:id, :incident_id, :evaluate_id, :resolution_id, :incident_category_id, :department_id, :closing_comment])
end
end

