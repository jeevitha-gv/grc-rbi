class CompaniesController < ApplicationController

  before_filter :authenticate_admin_user, :only => [:settings]

  def index
    @companies = Company.all
  end

  def new
    @company = Company.new    
  end

  def create
    @company = Company.new(company_params)    
    if @company.save      
      @company.users.create(user_params[:user])
      redirect_to welcome_path
    end    
  end

  def settings
  end

  private
  def company_params
    params.require(:company).permit(:name, :primary_email, :secondary_email, :domain, :address1, :address2, :country_id, :contact_no, :attachments_attributes =>[:attachment])
  end
  def user_params
    params.require(:company).permit(:user => [:email, :full_name])
  end
end
