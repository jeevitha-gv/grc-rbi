class ServicesController < ApplicationController
	layout 'asset_layout'
 
  def index
  	@services = current_company.assets
  end

  def new
  	@service = Service.new
    @service.build_asset
  end

  def create
  	@service = Service.new(service_params)
    @service.asset.company_id = current_company.id
    @service.asset.identifier_id = current_user.id
    @service.asset.asset_state_id = 1
    if @service.save
      redirect_to services_path
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
  	params.require(:service).permit(:service_type_id, :cost, :sla, :assigned_on, asset_attributes: [:id,:name, :description, :location_id, :department_id,:asset_state_id,:classification_id,:company_id, :owner_id,:custodian_id,:identifier_id,:evaluated_by,:personal_data,:sensitive_data,:customer_data,:confidentiality,:availability,:integrity])
  end

end
