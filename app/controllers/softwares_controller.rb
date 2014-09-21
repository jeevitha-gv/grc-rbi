class SoftwaresController < ApplicationController

  layout 'asset_layout'
  
  def index
  	@assets = current_company.assets.where(:assetable_type => "Software")
  end

  def new
  	@software = Software.new
    @software.build_asset
  end

  def create
  	@software = Software.new(software_params)
    @software.asset.company_id = current_company.id
    @software.asset.identifier_id = current_user.id
    @software.asset.asset_state_id = 1
  	if @software.save
  		redirect_to softwares_path,:flash => { :notice => MESSAGES["Software"]["create"]["success"]}
  	else
  		render 'new'
  	end
  end

  def show
      @software = Software.find(params[:id])
      # @incident=Evaluate.find(params[:id])
      respond_to do |format|
      format.html
      format.pdf do
      @pdf = (render_to_string pdf: "PDF", template: "softwares/show.pdf.erb", layout: 'layouts/pdf.html.erb', encoding: "UTF-8")
        send_data(@pdf, type: "application/pdf", filename: @software.asset.name)
      end
    end
  end

  def edit
  	@software = Software.find(params[:id])
  end

  def update
  	@software = Software.find(params[:id])
  	if @software.update_attributes(software_params)
  		redirect_to softwares_path,:flash => { :notice => MESSAGES["Software"]["update"]["success"]}
  	else
  		render 'new'
  	end
  end

   def destroy
    @software = Software.find(params[:id])
    @software.destroy
    render json: {:data=> "success"}
  end

  def software_export
    begin
      file_to_download = "sample-software.csv"
      send_file Rails.public_path + file_to_download, :type => 'text/csv; charset=iso-8859-1; header=present', :disposition => "attachment; filename=#{file_to_download}", :stream => true, :buffer_size => 4096
    rescue
      flash[:error] = MESSAGES["csv_export"]["error"]
      redirect_to new_software_path
    end
  end

  def software_imports
    if(params[:file].present?)
      begin
        Software.import_from_file(params[:file], current_company)
        flash[:notice] = MESSAGES["Software"]["csv_upload"]["success"]
        redirect_to softwares_path
      rescue
        flash[:notice]=  MESSAGES["csv_upload"]["error"]
        redirect_to new_software_path
      end
    else
      flash[:notice]=  MESSAGES["csv_upload"]["presence"]
      redirect_to new_software_path
    end
  end

  def software_params
  	params.require(:software).permit(:software_type_id, :product_name, :manufacturer, :vendor_id, :cost, :installation_date, :license_expiry_date, :license_key, :version, :license_type_id, :installation_path, :last_audit_date, :assigned_on, asset_attributes: [:id,:name, :description, :location_id, :department_id,:asset_state_id,:classification_id,:company_id, :owner_id,:custodian_id,:identifier_id,:evaluated_by,:personal_data,:sensitive_date,:customer_data,:confidentiality,:availability,:integrity])
  end

end
