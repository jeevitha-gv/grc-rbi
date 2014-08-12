class MobileAssetsController < ApplicationController
  def index
  	@mobile_assets = current_company.mobile_assets
  end
end
