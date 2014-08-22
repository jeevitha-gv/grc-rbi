class ServicesController < ApplicationController
	layout 'asset_layout'
  def index
  	@services = current_company.services
  end

  def new
  	@service = Service.new
  end

  def create
  	@service = current_company.services.new(service_params)
  	if @service.save
  		redirect_to services_path,:flash => { :notice => MESSAGES["Service"]["create"]["success"]}
  	else 
  		render 'new'
  	end
  end

  def edit
  	@service = Service.find(params[:id])
  end

  def update
  	@service = Service.find(params[:id])
  	if @service.update_attributes(service_params)
  		redirect_to services_path, :flash => { :notice => MESSAGES["Service"]["update"]["success"] }
  	else
  		render 'new'
  	end
  end

  def destroy
    @service = Service.find(params[:id])
    @service.destroy
    render json: {:data=> "success"}
  end
  def service_export
    begin
      file_to_download = "sample-service.csv"
      send_file Rails.public_path + file_to_download, :type => 'text/csv; charset=iso-8859-1; header=present', :disposition => "attachment; filename=#{file_to_download}", :stream => true, :buffer_size => 4096
    rescue
      flash[:error] = MESSAGES["csv_export"]["error"]
      redirect_to new_service_path
    end
  end

  def service_imports
    if(params[:file].present?)
      begin
        Service.import_from_file(params[:file], current_company)
        flash[:notice] = MESSAGES["Service"]["csv_upload"]["success"]
        redirect_to services_path
      rescue
        flash[:notice]=  MESSAGES["csv_upload"]["error"]
        redirect_to new_service_path
      end
    else
      flash[:notice]=  MESSAGES["csv_upload"]["presence"]
      redirect_to new_service_path
    end
  end

  def service_params
  	params.require(:service).permit(:name, :service_type_id, :description, :cost, :sla, :location_id, :department_id, :asset_manager_id, :asset_user_id, :assigned_on)
  end

end
