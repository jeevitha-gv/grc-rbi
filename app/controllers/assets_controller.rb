class AssetsController < ApplicationController

	before_filter :accessible_assets, :only => [:index]

	def index
		
	end

end