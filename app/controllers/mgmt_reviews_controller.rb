class MgmtReviewsController < ApplicationController
	layout "risk_layout"
	before_filter :current_risk

	def new
		@mgmt_review = @risk.mgmt_review.present? ? @risk.mgmt_review : @risk.build_mgmt_review
	end

	def create
		@mgmt_review = @risk.build_mgmt_review(mgmt_review_params)
		@mgmt_review.reviewer = current_user
		risk_status = params[:mgmt_review][:review_id] == 1 ? RiskStatus.where("name= ?", "Reviewed").first.id : RiskStatus.where("name= ?", "Rejected Risk").first.id
		if @mgmt_review.save
			@risk.update(risk_status_id: risk_status )
			flash[:notice] = "Risk is reviewed successfully" 
			redirect_to edit_risk_mgmt_review_path(id: @mgmt_review)
		else
			render "new"
		end
	end

	def edit
		@mgmt_review = @risk.mgmt_review
	end


	def update	
		@mgmt_review = @risk.mgmt_review
		risk_status = params[:mgmt_review][:review_id] == 1 ? RiskStatus.where("name= ?", "Reviewed").first.id : RiskStatus.where("name= ?", "Rejected Risk").first.id
		if @mgmt_review.update(mgmt_review_params)
			@risk.update(risk_status_id: risk_status )
			flash[:notice] = "Risk is reviewed Updated" 
			redirect_to edit_risk_mgmt_review_path(id: @mgmt_review)
		else
			render "edit"
		end
	end



	private

	def mgmt_review_params
		params.require(:mgmt_review).permit(:review_id, :reviewer, :next_step_id, comment_attributes: [:id, :comment])
	end
end