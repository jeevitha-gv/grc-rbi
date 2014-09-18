class InformationAssetsController < ApplicationController

  layout 'asset_layout'
  

  def index
    @assets = current_company.assets
  end

  def new
  	@information_asset = InformationAsset.new
  	@information_asset.build_asset
  end

  def create
  	@information_asset = InformationAsset.new(info_assets)
  	@information_asset.asset.company_id = current_company.id
    @information_asset.asset.asset_state_id = 1
    @information_asset.asset.identifier_id = current_user.id
  	if @information_asset.save
  		redirect_to information_assets_path
  	else 
  		redirect_to new_information_asset_path
  	end
  end

  def edit
    @information_asset = InformationAsset.find(params[:id])
  end

  def update 
    @information_asset = InformationAsset.find(params[:id])
    if @information_asset.update_attributes(info_assets)
      redirect_to information_assets_path 
    else
        redirect_to new_information_asset_path
    end
  end

  def destroy
    @information_asset = InformationAsset.find(params[:id])
    @information_asset.destroy
    render json: {:data=> "success"}
  end

  def info_assets
  	params.require(:information_asset).permit(:at_origin, :info_moved, :retention_period, asset_attributes: [:id,:name, :description, :location_id, :department_id,:asset_state_id,:classification_id,:company_id, :owner_id,:custodian_id,:identifier_id,:evaluated_by,:personal_data,:sensitive_date,:customer_data,:confidentiality,:availability,:integrity])
  end

end
