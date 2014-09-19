class AssetsController < ApplicationController

	layout 'asset_layout'

	before_filter :accessible_assets, :only => [:index]

	def index
		
	end

end