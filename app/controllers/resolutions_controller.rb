class ResolutionsController < ApplicationController
  def index
  	#@resolutions = current_user.resolutions
  end

  def new
  	@resolution = Resolution.new
  end

  def create
  	@resolution = current_company.resolutions.new(incident_params)

  	if @resolution.save
  		redirect_to resolutions_path
  	else
  		redirect_to new_resolution_path
  	end
  end
end
