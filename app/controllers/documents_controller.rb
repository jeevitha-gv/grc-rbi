class DocumentsController < ApplicationController

	layout 'asset_layout'

  def index
  	@assets = current_company.assets.where(:assetable_type => "Document")
  end

  def new
  	@document = Document.new
    @document.build_asset
  end

  def create
    @document = Document.new(document_params)
    @document.asset.company_id = current_company.id
    @document.asset.identifier_id = current_user.id
    @document.asset.asset_state_id = 1
    if @document.save
      redirect_to documents_path
    else 
      render new
    end
  end



  def show
      @document = Document.find(params[:id])
      # @incident=Evaluate.find(params[:id])
      respond_to do |format|
      format.html
      format.pdf do
      @pdf = (render_to_string pdf: "PDF", template: "documents/show.pdf.erb", layout: 'layouts/pdf.html.erb', encoding: "UTF-8")
        send_data(@pdf, type: "application/pdf", filename: @document.asset.name)
      end
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
  	params.require(:document).permit(:document_status_id, :document_type_id, :version,:assigned_on, asset_attributes: [:id,:name, :description, :location_id, :department_id,:asset_state_id,:classification_id,:company_id, :owner_id,:custodian_id,:identifier_id,:evaluated_by,:personal_data,:sensitive_date,:customer_data,:confidentiality,:availability,:integrity])
  end

end
