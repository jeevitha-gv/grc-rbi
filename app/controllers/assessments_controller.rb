class AssessmentsController < ApplicationController

	layout 'asset_layout'
	before_filter :current_asset

	def index
	end

	def new
		@assessment = @asset.assessment.present? ? @asset.assessment : @asset.build_assessment		
		@asset_info = @asset.assetable
	end

	def create
		@assessment = @asset.build_assessment(assess_params)
		if @assessment.save
			redirect_to asset_assessments_path
		else
			redirect_to new_asset_assessment_path
		end
	end

	def edit
		# binding.pry
		@assessment = @asset.assessment(asset_id: @asset.id)
	end

	def update
		@assessment = @asset.assessment
		if @assessment.update(assess_params)
			
			redirect_to asset_assessments_path
		else
			render "edit"
		end
	end

	def assess_params
		params.require(:assessment).permit(:asset_id,:labelling,:disposal,:transport,:storage,:addressing,:assessment,:conclusion,:closure_date)
	end



end
