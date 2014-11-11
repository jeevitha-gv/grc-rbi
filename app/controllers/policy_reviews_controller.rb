class PolicyReviewsController < ApplicationController
  layout 'policy_layout'
  before_filter :current_policy
  before_action :set_review, only: [:show, :edit, :update, :destroy]

  def index
    @policy_reviews = PolicyReview.all
  end

  def new
    @policy_review = @policy.policy_reviews.build
  end

  def create
    @policy_review = @policy.policy_reviews.build(review_params)
    @policy_review.reviewer_id=current_user.id
    if @policy_review.save
      redirect_to policies_path
    else
      render :new 
    end
  end

  def edit
  end

  def update
  end

  private

  # parameters
  def review_params
    params.require(:policy_review).permit(:review_action_id, comment_attributes: [:id, :comment])
  end

end