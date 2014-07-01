class MgmtReviewsController < ApplicationController
	before_filter :current_risk

	def new
		@mgmt_review = @risk.build_mgmt_review
	end

	def create
		@mgmt_review = @risk.build_mgmt_review(mgmt_review_params)
		@mgmt_review.reviewer = current_user
		if @mgmt_review.save
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
		if @mgmt_review.update(mgmt_review_params)
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