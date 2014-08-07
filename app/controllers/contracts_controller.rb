class ContractsController < ApplicationController

def index
  @contracts = current_company.contracts
end

def new
  @contract = Contract.new	
end

def create
  @asset = current_company.contracts.new(asset_params)
    if @asset.save
      redirect_to contracts_path
    else
      render 'new'
    end
  end

  private
    def asset_params
      params.require(:contract).permit(:name, :manufacturer, :contract_type_id, :contract_status_id, :notes, :location_id, :department_id)
    end

end
