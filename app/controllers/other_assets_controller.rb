class OtherAssetsController < ApplicationController

  layout 'asset_layout'

  def index
  	@other_assets = current_company.other_assets
  end

  def new
  	@other_asset = OtherAsset.new
  end

  def create
  	@other_asset = current_company.other_assets.new(other_asset_params)
  	if @other_asset.save
  		redirect_to other_assets_path
  	else
  		render 'new'
  	end
  end

  def other_asset_params
  	params.require(:other_asset).permit(:name, :manufacturer, :asset_type_id, :asset_status_id, :model, :serial_number, :aset_id, :ip, :description, :asset_owner, :asset_user, :location_id, :department_id, :maintenance_contract, :lease_contract)
  end

end
