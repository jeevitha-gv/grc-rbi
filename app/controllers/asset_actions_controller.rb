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
      params[:files].each do |a|
        Attachment.create(:attachment_file => a, :attachable_type => "AssetAction", :attachable_id => @asset_action.id, :company_id => current_company.id)
      end
      @asset.asset_state_id = 3
      @asset.save
      redirect_to asset_asset_actions_path
    else
      redirect_to new
    end
  end

  def edit
    @asset_action = @asset.asset_action(asset_id: @asset.id)
  end

  def update
        @asset_action = @asset.asset_action
      if @asset_action.update(action_params)
        # params[:files].each do |a|
        # Attachment.update(:attachment_file => a, :attachable_type => "AssetAction", :attachable_id => @asset_action.id, :company_id => current_company.id)
        # end 
       
        redirect_to asset_asset_actions_path
      else
        render "edit"
      end
  end

  private

  def action_params
    
    params.require(:asset_action).permit(:custodian_actions, files: [], attachments_attributes: [:id, :attachment_file, :company_id])
  end

end
