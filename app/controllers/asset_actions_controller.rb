class AssetActionsController < ApplicationController

  layout 'asset_layout'
  before_filter :current_asset

  def index
  end

  def new
  	@asset_action = @asset.asset_action.present? ? @asset.asset_action : @asset.build_asset_action
  	@assessment = @asset.assessment
  	@asset_info = @asset.assetable
  end

  def create
    @asset_action = @asset.build_asset_action(action_params)
    if @asset_action.save
      redirect_to asset_asset_actions_path
    else
      redirect_to new
    end
  end

  def edit
  end

  def update
  end

  private

  def action_params
    
    params.require(:asset_action).permit(:custodian_actions, attachments_attributes: [:id, :attachment_file, :company_id])
  end

end
