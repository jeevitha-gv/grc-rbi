class InvestigationsController < ApplicationController
   layout 'fraud_layout'
  before_filter :current_fraud
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
      @fraud.fraud_status_id = 2
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
    params.require(:investigation).permit(:fraud_id, :summary, :closing_id, :finding_id, :rating_id, :actual_loss, :assign_for)
  end
end
