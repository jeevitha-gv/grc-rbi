class SourceCodesController < ApplicationController
  def index
  	  	@sourcecode = current_company.assets
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
  		redirect_to new_source_code_path
  	end
  end

  def edit
  	@sourcecode = SourceCode.find(params[:id])
  end

  def sourcecode_params
  	params.require(:source_code).permit(:vcs_url, :project_manager, :version_number, :backup_measure, :assigned_on, :expected_life, asset_attributes: [:id,:name, :description, :location_id, :department_id,:asset_state_id,:classification_id,:company_id, :owner_id,:custodian_id,:identifier_id,:evaluated_by,:personal_data,:sensitive_date,:customer_data,:confidentiality,:availability,:integrity])
  end
end
