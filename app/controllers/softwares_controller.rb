class SoftwaresController < ApplicationController

  layout 'asset_layout'
  
  def index
  	@softwares = current_company.softwares
  end

  def new
  	@software = Software.new
  end

  def create
  	@software = current_company.softwares.new(software_params)
  	if @software.save
  		redirect_to softwares_path,:flash => { :notice => MESSAGES["Software"]["create"]["success"]}
  	else
  		render 'new'
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
  	params.require(:software).permit(:software_type_id, :product_name, :description, :manufacturer, :vendor_id, :cost, :license_years, :license_months, :installation_date, :license_expiry_date, :license_key, :version, :license_type_id, :installation_path, :last_audit_date, :location_id, :department_id, :asset_manager_id, :asset_user_id, :assigned_on)
  end

end
