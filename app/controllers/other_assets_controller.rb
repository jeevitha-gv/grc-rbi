class OtherAssetsController < ApplicationController

  def index
  	@other_assets = current_company.other_assets
  end

  def new
  	@other_asset = OtherAsset.new
  end

 def create
    @asset = current_company.other_assets.new(asset_params)
    if @asset.save
      redirect_to other_assets_path
    else
      render 'new'
    end
  end

  private
    def asset_params
      params.require(:other_asset).permit(:company_id, :name, :manufacturer, :asset_type_id, :asset_status_id, :model, :serial_number, :asset_id, :ip, :description, :asset_owner, :asset_user, :location_id, :department_id, :maintenance_contact, :lease_contact)
    end

end
