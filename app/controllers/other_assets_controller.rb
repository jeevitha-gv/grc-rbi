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

  def edit
    @other_asset = OtherAsset.find(params[:id])
  end

  def update
    @other_asset = OtherAsset.find(params[:id])
    if @other_asset.update_attributes(other_asset_params)
      redirect_to other_assets_path, :flash => { :notice => MESSAGES["OtherAsset"]["update"]["success"] }
    else
      render 'new'
    end
  end

  def other_asset_export
    begin
      file_to_download = "other-assets-sample.csv"
      send_file Rails.public_path + file_to_download, :type => 'text/csv; charset=iso-8859-1; header=present', :disposition => "attachment; filename=#{file_to_download}", :stream => true, :buffer_size => 4096
    rescue
      flash[:error] = MESSAGES["csv_export"]["error"]
      redirect_to new_audit_path
    end
  end

  def other_asset_imports
    if(params[:file].present?)
      begin
        OtherAsset.import_from_file(params[:file], current_company)
        flash[:notice] = MESSAGES["OtherAsset"]["csv_upload"]["success"]
        redirect_to other_assets_path
      rescue
        binding.pry
        flash[:notice]=  MESSAGES["csv_upload"]["error"]
        redirect_to new_other_asset_path
      end
    else
      flash[:notice]=  MESSAGES["csv_upload"]["presence"]
      redirect_to new_other_asset_path
    end
  end

  def download_other_asset_document
    attachment = Attachment.find(params[:id])
    send_file(Rails.public_path.to_s + attachment.attachment_file_url)
  end

  def download_document
      attachment = Attachment.find(params[:id])
      send_file(Rails.public_path.to_s + attachment.attachment_file_url)
  end

  def remove_attachment
    attachment = Attachment.find(params[:id])
    attachment.delete
  end


  def other_asset_params
  	params.require(:other_asset).permit(:name, :manufacturer, :asset_type_id, :asset_status_id, :model, :serial_number, :aset_id, :ip, :description, :asset_owner, :asset_user, :location_id, :department_id, :maintenance_contract, :lease_contract, attachment_attributes: [:id, :attachment_file, :company_id])
  end

end
