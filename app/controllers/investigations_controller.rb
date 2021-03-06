class InvestigationsController < ApplicationController
   layout 'fraud_layout'
  before_filter :current_fraud
  before_filter :authorize_fraud, :only => [:new, :create, :update, :edit] 
  # before_filter :authorize_evaluator, :only => [:new, :create,:edit,:update]
  # before_filter :accessible_assets, :only => [:index]

  def index
  
  end

  def new
    @investigate = @fraud.investigation.present? ? @fraud.investigation : @fraud.build_investigation    
  end

  def create
    @investigate = @fraud.build_investigation(inv_params)    
    if @investigate.save
      @fraud.fraud_status_id = 1
      @fraud.save
      redirect_to fraud_investigations_path
    else
      redirect_to new_fraud_investigation_path
    end
  end

  def edit
    @investigate = @fraud.investigation(fraud_id: @fraud.id)
  end

  def update
    @investigate = @fraud.investigation
    if @investigate.update(inv_params)
      
      redirect_to fraud_investigations_path
    else
      render "edit"
    end
  end

  private

  def inv_params
    params.require(:investigation).permit(:fraud_id, :internal_investigation_protocol, :remediation_protocol, :enforcement_and_accountability_protocol, :disclosure_protocol, :summary, :closing_id, :finding_id, :rating_id, :actual_loss, :assign_for)
  end

  def authorize_fraud
    if(current_user.role_title != "Investigator" && current_user.role_title != "company_admin")
      flash[:alert] = "Access Restricted"
      redirect_to frauds_path
  end
end
end
