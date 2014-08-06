class VendorsController < ApplicationController
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

  def vendor_params
    params.require(:vendor).permit(:name, :reseller_type_id, :contact_name, :contact_email, :contact_phone, :url, :telephone, :address, :city, :state, :zip, :note)
  end
end
