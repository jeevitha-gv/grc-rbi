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
  		redirect_to computers_path, :flash => { :notice => MESSAGES["Computer"]["create"]["success"]}
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

  def computer_export
    begin
      file_to_download = "sample-computerasset.csv"
      send_file Rails.public_path + file_to_download, :type => 'text/csv; charset=iso-8859-1; header=present', :disposition => "attachment; filename=#{file_to_download}", :stream => true, :buffer_size => 4096
    rescue
      flash[:error] = MESSAGES["csv_export"]["error"]
      redirect_to new_computer_path
    end
  end

  def computer_imports
    if(params[:file].present?)
      begin
        Computer.import_from_file(params[:file], current_company)
        flash[:notice] = MESSAGES["Computer"]["csv_upload"]["success"]
        redirect_to computers_path
      rescue
        flash[:notice]=  MESSAGES["csv_upload"]["error"]
        redirect_to new_computer_path
      end
    else
      flash[:notice]=  MESSAGES["csv_upload"]["presence"]
      redirect_to new_computer_path
    end
  end

  private

  def computer_params
  	params.require(:computer).permit(:name, :serial, :manufacturer, :ip, :computer_category_id, :asset_status_id, :location_id, :department_id, :technical_contact, :asset_owner)
  end
  
end
