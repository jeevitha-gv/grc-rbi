class SourceCodesController < ApplicationController

  layout 'asset_layout'

  def index
  	  	@assets = current_company.assets.where(:assetable_type => "SourceCode")
  end

  def new
  	@sourcecode = SourceCode.new
    @sourcecode.build_asset
  end

  def create
    @sourcecode = SourceCode.new(sourcecode_params)
    @sourcecode.asset.company_id = current_company.id
    @sourcecode.asset.identifier_id = current_user.id
    @sourcecode.asset.asset_state_id = 1
  	if @sourcecode.save
  		redirect_to source_codes_path
  	else
  		render new
  	end
  end

  def edit
  	@sourcecode = SourceCode.find(params[:id])
  end

  def update
    @source_code = SourceCode.find(params[:id])
    if @source_code.update_attributes(sourcecode_params)
      redirect_to source_codes_path
    else
      render new
    end
  end

  def show
    @sourcecode = SourceCode.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf do
      @pdf = (render_to_string pdf: "PDF", template: "source_codes/show.pdf.erb", layout: 'layouts/pdf.html.erb', encoding: "UTF-8")
        send_data(@pdf, type: "application/pdf", filename: @sourcecode.asset.name)
      end
    end
  end

  def sourcecode_export
    begin
      file_to_download = "sourcecode_assets.csv"
      send_file Rails.public_path + file_to_download, :type => 'text/csv; charset=iso-8859-1; header=present', :disposition => "attachment; filename=#{file_to_download}", :stream => true, :buffer_size => 4096
    rescue
      flash[:error] = MESSAGES["csv_export"]["error"]
      redirect_to new_audit_path
    end
  end

  def sourcecode_imports
    if(params[:file].present?)
      begin
        SourceCode.import_from_file(params[:file], current_company, current_user)
        flash[:notice] = MESSAGES["risk"]["csv_upload"]["success"]
        redirect_to source_codes_path
      rescue
        flash[:notice]=  MESSAGES["csv_upload"]["error"]
        redirect_to new_source_code_path
      end
    else
      flash[:notice]=  MESSAGES["csv_upload"]["presence"]
      redirect_to new_source_code_path
    end
  end

  private

  def sourcecode_params
  	params.require(:source_code).permit(:vcs_url, :project_manager, :version_number, :backup_measure, :assigned_on, :expected_life, asset_attributes: [:id, :name, :description, :location_id, :department_id, :asset_state_id, :classification_id, :company_id, :owner_id, :custodian_id, :identifier_id, :evaluated_by, :personal_data, :sensitive_date, :customer_data, :confidentiality, :availability, :integrity, :asset_users])
  end

end
