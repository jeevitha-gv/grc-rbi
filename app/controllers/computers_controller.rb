#require 'rqrcode_png'
class ComputersController < ApplicationController


  layout 'asset_layout'

  def index
  	 @assets = current_company.assets.where(:assetable_type => "Computer")
    #@qr = RQRCode::QRCode.new( "http://codingricky.com").to_img.resize(200, 200).to_data_url
    # puts RQRCode::QRCode.new( "http://codingricky.com").to_img.resize(200, 200)
  
  end

  def new
    @computer = Computer.new
    @computer.build_asset
  end

  def create
  	@computer = Computer.new(computer_params)
    @computer.asset.company_id = current_company.id
    @computer.asset.asset_state_id = 1
    @computer.asset.identifier_id = current_user.id
    if @computer.save
      redirect_to computers_path
    else 
      render new
    end
  end

  def edit
  	@computer = Computer.find(params[:id])
  end

  def update
  	@computer = Computer.find(params[:id])
  	if @computer.update_attributes(computer_params)
  		redirect_to computers_path, :flash => { :notice => MESSAGES["Computer"]["update"]["success"] }
  	else
  		render 'new'
  	end
  end

  def computer_export
    begin
      file_to_download = "computer_assets.csv"
      send_file Rails.public_path + file_to_download, :type => 'text/csv; charset=iso-8859-1; header=present', :disposition => "attachment; filename=#{file_to_download}", :stream => true, :buffer_size => 4096
    rescue
      flash[:error] = MESSAGES["csv_export"]["error"]
      redirect_to new_computer_path
    end
  end

  def computer_imports
    if(params[:file].present?)
      begin
        Computer.import_from_file(params[:file], current_company, current_user)
        flash[:notice] = MESSAGES["Computer"]["csv_upload"]["success"]
        redirect_to computers_path
      rescue
        flash[:notice]=  MESSAGES["csv_upload"]["error"]
        redirect_to new_computer_path
      end
    else
      flash[:notice]=  MESSAGES["csv_upload"]["presence"]
      redirect_to computers_path
    end
  end

  def destroy
    @computer = Computer.find(params[:id])
    @computer.destroy
    render json: {:data=> "success"}
  end

  private

  def computer_params
  	params.require(:computer).permit(:serial, :ip, :computer_category_id, :asset_status_id, :operating_system_id, :os_ver_ser, :memory, :disk_space, :cpu_speed, :cpu_core_count, :mac, :cost, :acquisition_date, :expiry_date, :last_audit_date, :assigned_on, :vendor_id, :contract_id,  asset_attributes: [:id,:name, :description, :location_id, :department_id,:asset_state_id,:classification_id,:company_id, :owner_id,:custodian_id,:identifier_id,:evaluated_by,:personal_data,:sensitive_data,:customer_data,:confidentiality,:availability,:integrity, :asset_users])
  end

end
