class FraudsController < ApplicationController
before_filter :fraud_investigator_users, :only => [:new, :create, :edit, :update]
# before_filter :authorize_fraud, :only => [:new, :create, :edit, :update]


  def index
  	@frauds = current_company.frauds
  end

  def new
  	@fraud = Fraud.new
  end

  def create
  	@fraud = Fraud.new(fraud_params)
  	if @fraud.save
  		redirect_to frauds_path
  	else
  		render new
  	end
  end

  def edit
  	@fraud = Fraud.find(params[:id])
  end

  def fraud_params
  	params.require(:fraud).permit(:company_id, :subject, :control, :reference, :location_id, :fraud_type_id, :technology_id, :investigator, :fraud_manager, :team_id, :fraud_status_id, :person_responsible, :investigation_object_id, :fraud_assessment, :risk_value_id, :additional_note)
  end

  def fraud_investigator_users
      @investigator_users = current_company.users.where(:is_disabled => false)
      # @risks = current_company.risks.collect{|x| x if (x.mgmt_review.present? && x.mgmt_review.next_step_id == 3)}.compact if current_company.plan.subscription.section_ids.include?('2')
  end


  def fraud_manager_users
      @fraud_manager_users = current_company.users.where(:is_disabled => false)
      # @risks = current_company.risks.collect{|x| x if (x.mgmt_review.present? && x.mgmt_review.next_step_id == 3)}.compact if current_company.plan.subscription.section_ids.include?('2')
  end

  #   def download_risk_document
  #   attachment = Attachment.find(params[:id])
  #   send_file(Rails.public_path.to_s + attachment.attachment_file_url)
  # end


  #   def download_document
  #     attachment = Attachment.find(params[:id])
  #     send_file(Rails.public_path.to_s + attachment.attachment_file_url)
  #   end

  # def remove_attachment
  #   attachment = Attachment.find(params[:id])
  #   attachment.delete
  # end

end
