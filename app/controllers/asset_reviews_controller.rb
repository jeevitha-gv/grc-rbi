class AssetReviewsController < ApplicationController
	layout 'asset_layout'
	before_filter :current_asset

  def index

  end

  def new 
  	@asset_review = @asset.asset_review.present? ? @asset.asset_review : @asset.build_asset_review
		# @assessment = @asset.build_assessment
	
	@asset_info = @asset.assetable
  end

  def create
		@asset_review = @asset.build_asset_review(review_params)
		if @asset_review.save
			redirect_to asset_asset_reviews_path
		else
			redirect_to new_asset_asset_review_path
		end
	end

	private

	def review_params
		binding.pry
		params.require(:asset_review).permit(:asset_decision_id,:next_review,:closure_statement)
	end

end
