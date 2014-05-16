class CompaniesController < ApplicationController

  def index
    @companies = Company.all
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)

    if @company.save
      redirect_to welcome_path
    end
  end

  private
  def company_params
    params.require(:company).permit(:name, :primary_email, :secondary_email, :domain, :address1, :address2, :contact_no)
  end

end
