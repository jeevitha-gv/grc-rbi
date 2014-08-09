class VendorsController < ApplicationController

  layout 'asset_layout'
  
  def index
  	@vendors = current_company.vendors
  end

  def new
  	@vendor = Vendor.new
  end

  def create
  	@vendor = current_company.vendors.new(vendor_params)
  	if @vendor.save
  		redirect_to vendors_path, :flash => { :notice => MESSAGES["Vendor"]["create"]["success"] }
  	else
  		render 'new'
  	end
  end

    def edit
      @vendor = Vendor.find(params[:id])
    end

    def update
    @vendor = Vendor.find(params[:id])
    #@risk.set_risk_status(@risk, params[:commit]) if params[:commit] == "Initiate Risk"
    if @vendor.update_attributes(vendor_params)
      redirect_to vendors_path, :flash => { :notice => MESSAGES["Vendor"]["update"]["success"] }
    else
      #risk_initializers(@risk.location_id, @risk.department_id, @risk.team_id, @risk.compliance_id)
      render 'edit'
    end
  end

  def vendor_export
    begin
      file_to_download = "sample-vendor.csv"
      send_file Rails.public_path + file_to_download, :type => 'text/csv; charset=iso-8859-1; header=present', :disposition => "attachment; filename=#{file_to_download}", :stream => true, :buffer_size => 4096
    rescue
      flash[:error] = MESSAGES["csv_export"]["error"]
      redirect_to new_audit_path
    end
  end

  def vendor_imports
    if(params[:file].present?)
      begin
        Vendor.import_from_file(params[:file], current_company)
        flash[:notice] = MESSAGES["Vendor"]["csv_upload"]["success"]
        redirect_to vendors_path
      rescue
        flash[:notice]=  MESSAGES["csv_upload"]["error"]
        redirect_to new_vendor_path
      end
    else
      flash[:notice]=  MESSAGES["csv_upload"]["presence"]
      redirect_to new_vendor_path
    end
  end

  def vendor_params
    params.require(:vendor).permit(:name, :reseller_type_id, :contact_name, :contact_email, :contact_phone, :url, :telephone, :address, :city, :state, :zip, :note)
  end
end
