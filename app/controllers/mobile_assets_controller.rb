class MobileAssetsController < ApplicationController

  layout 'asset_layout'

  def index
  	@mobile_assets = current_company.mobile_assets
  end

  def new
  	@mobile_asset = MobileAsset.new
  end

  def create
  	@mobile_asset = current_company.mobile_assets.new(mobile_asset_params)
  	if @mobile_asset.save
  		redirect_to mobile_assets_path, :flash => { :notice => MESSAGES["MobileAsset"]["create"]["success"] }
  	else
  		render 'new'
  	end
  end

  def edit
		@mobile_asset = MobileAsset.find(params[:id])
	end

  def update
    @mobile_asset = MobileAsset.find(params[:id])
    #@risk.set_risk_status(@risk, params[:commit]) if params[:commit] == "Initiate Risk"
    if @mobile_asset.update_attributes(mobile_asset_params)
      redirect_to mobile_assets_path, :flash => { :notice => MESSAGES["MobileAsset"]["update"]["success"]}
    else
      #risk_initializers(@risk.location_id, @risk.department_id, @risk.team_id, @risk.compliance_id)
      render 'edit'
    end
  end

  def mobile_asset_export
    begin
      file_to_download = "mobile-assets-sample.csv"
      send_file Rails.public_path + file_to_download, :type => 'text/csv; charset=iso-8859-1; header=present', :disposition => "attachment; filename=#{file_to_download}", :stream => true, :buffer_size => 4096
    rescue
      flash[:error] = MESSAGES["csv_export"]["error"]
      redirect_to new_audit_path
    end
  end

  def mobile_asset_imports
    if(params[:file].present?)
      begin
        MobileAsset.import_from_file(params[:file], current_company)
        flash[:notice] = MESSAGES["risk"]["csv_upload"]["success"]
        redirect_to mobile_assets_path
      rescue
        flash[:notice]=  MESSAGES["csv_upload"]["error"]
        redirect_to new_mobile_asset_path
      end
    else
      flash[:notice]=  MESSAGES["csv_upload"]["presence"]
      redirect_to new_mobile_asset_path
    end
  end

  def destroy
    @mobile_asset = MobileAsset.find(params[:id])
    @mobile_asset.destroy
    render json: {:data=> "success"}
  end

  private

    def mobile_asset_params
  		params.require(:mobile_asset).permit(:model, :manufacturer, :serial_number, :service_provider, :imei, :description, :device_type_id, :location_id, :department_id)
  	end

end
