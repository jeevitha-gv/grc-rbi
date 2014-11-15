class BcAnalysesController < ApplicationController

  def index
  	@bu = current_company.bc_analyses
  end

  def new
  	@bu = BcAnalysis.new
  end

  def create
  
  	@bu = BcAnalysis.new(bc_params)
  	@bu.company_id = current_company.id
  	if @bu.save
  		redirect_to bc_analyses_path
  	else
  		render new
  	end
  end

  def edit
  	@bu = BcAnalysis.find(params[:id])
  end

  def update
  	@bu = BcAnalysis.find(params[:id])
  	if @bu.update_attributes(bc_params)
  		redirect_to bc_analyses_path
  	else
  		render new
  	end
  end

  def bc_params
  	params.require(:bc_analysis).permit(:title, :department_id, :bu_process_id, :threat_id, :vulnerability_id, :threat_desc, :vul_desc, :impact, :business_impact, :business_req, :tech_req, :recovery_req, :confidentiality, :integrity, :availability, :owner, :manager, :assessment, :note,:company_id)
  end

end
