class DocumentsController < ApplicationController
	layout 'asset_layout'
  def index
  	@documents = current_company.documents
  end

  def new
  	@document = Document.new
  end

  def create
  	@document = current_company.documents.new(document_params)
  	if @document.save
  		redirect_to documents_path, :flash => { :notice => MESSAGES["Document"]["create"]["success"]}
  	else
  		render 'new'
  	end
  end

  def edit
  	@document = Document.find(params[:id])
  end

  def update
  	@document = Document.find(params[:id])
  	if @document.update_attributes(document_params)
  		
  		redirect_to documents_path, :flash => { :notice => MESSAGES["Document"]["update"]["success"]}
  	else
  		render 'new'
  	end
  end

  def destroy
    @document = Document.find(params[:id])
    @document.destroy
    render json: {:data=> "success"}
  end

  def document_export
    begin
      file_to_download = "sample-document.csv"
      send_file Rails.public_path + file_to_download, :type => 'text/csv; charset=iso-8859-1; header=present', :disposition => "attachment; filename=#{file_to_download}", :stream => true, :buffer_size => 4096
    rescue
      flash[:error] = MESSAGES["csv_export"]["error"]
      redirect_to new_document_path
    end
  end

  def document_imports
    if(params[:file].present?)
    	
      begin
        Document.import_from_file(params[:file], current_company)
       
        flash[:notice] = MESSAGES["Document"]["csv_upload"]["success"]
        redirect_to documents_path
      rescue
      	
        flash[:notice]=  MESSAGES["csv_upload"]["error"]
        redirect_to new_document_path
      end
    else
      binding.pry
      flash[:notice]=  MESSAGES["csv_upload"]["presence"]
      redirect_to new_document_path
    end
  end

  def document_params
  	params.require(:document).permit(:description, :document_status_id, :document_type_id, :version, :location_id, :department_id, :asset_manager_id, :asset_user_id, :assigned_on)
  end

end
