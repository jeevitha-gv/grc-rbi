class MobileAssetsController < ApplicationController

  layout 'asset_layout'
  

  def index
  	@assets = current_company.assets.where(:assetable_type => "MobileAsset")
  end

  def new
  	@mobile_asset = MobileAsset.new
    @mobile_asset.build_asset
  end

  def create
  	@mobile_asset = MobileAsset.new(mobile_asset_params)
    @mobile_asset.asset.company_id = current_company.id
    @mobile_asset.asset.asset_state_id = 1
    @mobile_asset.asset.identifier_id = current_user.id
  	if @mobile_asset.save
  		redirect_to mobile_assets_path, :flash => { :notice => MESSAGES["MobileAsset"]["create"]["success"] }
  	else
  		render 'new'
  	end
  end
  
  def show
      @mobile_asset = MobileAsset.find(params[:id])
      respond_to do |format|
      format.html
      format.pdf do
      @pdf = (render_to_string pdf: "PDF", template: "mobile_assets/show.pdf.erb", layout: 'layouts/pdf.html.erb', encoding: "UTF-8")
        send_data(@pdf, type: "application/pdf", filename: @mobile_asset.model)
      end
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
  		params.require(:mobile_asset).permit(:model, :manufacturer, :serial_number, :service_provider, :imei, :device_type_id, asset_attributes: [:id,:name, :description, :location_id, :department_id,:asset_state_id,:classification_id,:company_id, :owner_id,:custodian_id,:identifier_id,:evaluated_by,:personal_data,:sensitive_date,:customer_data,:confidentiality,:availability,:integrity])
  	end

end
