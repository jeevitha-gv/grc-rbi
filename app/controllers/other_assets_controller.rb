class OtherAssetsController < ApplicationController

  layout 'asset_layout'

  def index
  	@other_assets = current_company.other_assets
  end
  
end
