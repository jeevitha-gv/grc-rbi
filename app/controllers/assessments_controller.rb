class AssessmentsController < ApplicationController

	layout 'asset_layout'

	def index
	end

	def new
		@assessment = Assessment.new
	end

end
