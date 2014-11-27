class FraudReviewsController < ApplicationController
  layout 'fraud_layout'
  before_filter :current_fraud
  # before_filter :authorize_evaluator, :only => [:new, :create,:edit,:update]
  # before_filter :accessible_assets, :only => [:index]

  def index
  
  end

  def new
    @review = @fraud.fraud_review.present? ? @fraud.fraud_review : @fraud.build_fraud_review    
  end

  def create
    @review = @fraud.build_fraud_review(review_params)    
    if @review.save
      redirect_to fraud_fraud_reviews_path
    else
      redirect_to new_fraud_fraud_review_path
    end
  end

  def edit
    @review = @fraud.fraud_review(fraud_id: @fraud.id)
  end

  def update
    @review = @fraud.fraud_review
    if @review.update(review_params)
      
      redirect_to fraud_fraud_reviews_path
    else
      render "edit"
    end
  end

  private

  def review_params
    params.require(:fraud_review).permit(:fraud_id, :assign_to, :detection_strategy, :detection_method)
  end
end
