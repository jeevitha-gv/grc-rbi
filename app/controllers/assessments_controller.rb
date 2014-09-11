class AssessmentsController < ApplicationController

	layout 'asset_layout'
	before_filter :current_asset

	def index
	end

	def new
		binding.pry
		@assessment = @asset.assessment.present? ? @asset.assessment : @asset.assessment
		@asset_info = @asset.assetable
	end

end
