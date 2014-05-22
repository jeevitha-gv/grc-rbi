class CompaniesController < ApplicationController

  before_filter :authenticate_admin_user, :only => [:settings]
  prepend_before_filter :skip_if_authenticated, only: [ :new, :create ]
  skip_before_filter :check_subdomain, only: [ :new, :create ]
  before_filter :escape_subdomain, only: [ :new, :create ]

  def index
    @companies = Company.all
  end

  def new
    @company = Company.new
    @company.attachments.build
    @company.users.build
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      redirect_to welcome_path
    else
      redirect_to current_path_without_subdomain
    end
  end

  def settings
  end

  private
  def company_params
    params.require(:company).permit(:name, :primary_email, :secondary_email, :domain, :address1, :address2, :country_id, :contact_no, :timezone, attachments_attributes: [:attachment_file], users_attributes: [:user_name, :email])
  end
end
