class OtherAssetsController < ApplicationController
  def index
  	@other_assets = current_company.other_assets
  end
end
