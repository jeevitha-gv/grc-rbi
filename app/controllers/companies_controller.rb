class CompaniesController < ApplicationController
  
  skip_before_filter :authenticate_user!, only: [ :new, :create ]
  before_filter :authenticate_admin_user, :only => [:settings]
  prepend_before_filter :skip_if_authenticated, only: [ :new, :create ]
  skip_before_filter :check_subdomain, only: [ :new, :create ]
  before_filter :escape_subdomain, only: [ :new, :create ]
  # load_and_authorize_resource

  def index
    @companies = Company.all
  end

  def new
    @company = Company.new
    @company.build_attachment
    @company.users.build
  end

  def create
    params[:company][:users_attributes]["0"][:role_id] = "1"
    @company = Company.new(company_params)
    if @company.save
      redirect_to welcome_path
    else
      render 'new'
  end
  end



  def settings
  end

  private
  def company_params
    params.require(:company).permit(:name, :primary_email, :secondary_email, :domain, :address1, :address2, :country_id, :contact_no, :timezone, attachment_attributes: [:id, :attachment_file], users_attributes: [:user_name, :email, :role_id])
  end
end
