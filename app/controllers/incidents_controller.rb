class IncidentsController < ApplicationController

  def index
  	@incidents = current_user.incidents

  end

  def new
    @incident = Incident.new
  end

  def create
  	@incident = current_company.incidents.new(incident_params)
  	
  	if @incident.save
  		redirect_to incidents_path
  	else
  		redirect_to new_incident_path
  	end
	end
end