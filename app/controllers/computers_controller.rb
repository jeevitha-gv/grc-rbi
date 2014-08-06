class ComputersController < ApplicationController

  def index
  	@computers = current_company.computers
  end

  def new
    @computer = Computer.new
  end

  def create
  	@computer = current_company.computers.new(computer_params)
  	if @computer.save
  		redirect_to computers_path, :flash => { :notice => MESSAGES["Computer"]["create"]}
  	else
  		render 'new'
  	end
  end

  def edit
  	@computer = Computer.find(params[:id])
  end

  def update
  	@computer = Computer.find(params[:id])
  	if @computer.update_attributes(computer_params)
  		redirect_to computers_path, :flash => { :notice => MESSAGES["Computer"]["update"]["success"] }
  	else
  		render 'new'
  	end
  end

  private

  def computer_params
  	params.require(:computer).permit(:name, :serial, :manufacturer, :ip, :computer_category_id, :asset_status_id, :location_id, :department_id, :technical_contact, :asset_owner)
  end
  
end
