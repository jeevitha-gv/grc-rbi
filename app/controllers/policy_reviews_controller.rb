class PolicyReviewsController < ApplicationController
  layout 'policy_layout'
  before_filter :current_policy

  def new
    @policy_review = @policy.policy_reviews.build
  end

  def create
    @policy_review = @policy.policy_reviews.build(review_params)
    @policy_review.reviewer_id = current_user.id
    if @policy_review.save
      redirect_to policies_path
    else
      render :new 
    end
  end

  def edit
    @policy_review = @policy.policy_reviews.find(params[:id])
  end

  def update
    @policy_review = @policy.policy_reviews.find(params[:id])
    if @policy_review.update(review_params)
      flash[:notice] = "Policy is updated successfully"
      redirect_to policies_path
    else
      render "edit"
    end
  end

  private

  # parameters
  def review_params
    params.require(:policy_review).permit(:review_action_id, comment_attributes: [:id, :comment])
  end

end