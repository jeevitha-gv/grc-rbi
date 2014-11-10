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

    respond_to do |format|
      if @policy_review.save
        format.html { redirect_to policies_path, notice: 'Reviewed successfully' }
        format.json { render :show, status: :created, location: policies_path }
      else
        format.html { render :new }
        format.json { render json: @prof.errors, status: :unprocessable_entity }
      end
    end
    end

 
  def edit

  end

  def update

respond_to do |format|
      if @policy_review.update(review_params)
        format.html { redirect_to @policy_review, notice: 'Prof was successfully updated.' }
        format.json { render :show, status: :ok, location: @policy_review }
      else
        format.html { render :edit }
        format.json { render json: @policy_review.errors, status: :unprocessable_entity }
      end
    end
    end

   def show
  end


  def destroy
    @policy_review.destroy
    respond_to do |format|
      format.html { redirect_to policy_policy_reviews_url, notice: 'Prof was successfully destroyed.' }
      format.json { head :no_content }
   
  end
end
  private

def set_review
      @policy_review = @policy.policy_reviews.find(params[:id])
    end
  # parameters
    def review_params
    params.require(:policy_review).permit(:review_action_id, comment_attributes: [:id, :comment])
  end

end
