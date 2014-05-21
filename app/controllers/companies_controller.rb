class CompaniesController < ApplicationController

  before_filter :authenticate_admin_user, :only => [:settings]
  prepend_before_filter :skip_if_authenticated, only: [ :new, :create ]
  skip_before_filter :check_subdomain, only: [ :new, :create ]
  before_filter :escape_subdomain, only: [ :new, :create ]

  def index
    @companies = Company.all
  end

  def new
<<<<<<< HEAD
    @company = Company.new
    @company.attachments.build
=======
    @company = Company.new    
>>>>>>> 89a968c4c095e36eaa402c65b32596147d2b42f2
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
<<<<<<< HEAD
    params.require(:company).permit(:name, :primary_email, :secondary_email, :domain, :address1, :address2, :country_id, :contact_no, attachments_attributes: [:attachment_file])
=======
    params.require(:company).permit(:name, :primary_email, :secondary_email, :domain, :address1, :address2, :country_id, :contact_no, :attachments_attributes =>[:attachment])
  end
  def user_params
    params.require(:company).permit(:user => [:email, :user_name])
>>>>>>> 89a968c4c095e36eaa402c65b32596147d2b42f2
  end
end
