class ContractsController < ApplicationController

def index
  @contracts = current_company.contracts
end

def new
  @contract = Contract.new	
end

def create
  @contract = current_company.contracts.new(asset_params)
    if @contract.save
      redirect_to contracts_path, :flash => {:notice => MESSAGES["Contract"]["create"]["success"]}
    else
      render 'new'
    end
end

def edit
  @contract = Contract.find(params[:id])
end

def update
  @contract = Contract.find(params[:id])
  if @contract.update_attributes(asset_params)
    redirect_to contracts_path, :flash => {:notice => MESSAGES["Contract"]["update"]["success"]}
  else 
    render 'edit'
  end
end

  private
    def asset_params
      params.require(:contract).permit(:name, :manufacturer, :contract_type_id, :contract_status_id, :notes, :location_id, :department_id)
    end

end
