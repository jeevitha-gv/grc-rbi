class BcmDashboardController < ApplicationController
	layout 'bcm_layout'

  def index

  		@bca = BcAnalysis.joins(:threat).select("name,count(threat_id) as count").group(:name, :threat_id).order('name')
  		@bca1 = BcAnalysis.joins(:vulnerability).select("name,count(vulnerability_id) as count").group(:name, :vulnerability_id).order('name')
  		@bca2 = BcAnalysis.joins(:bu_process).select("name,count(bu_process_id) as count").group(:name, :bu_process_id).order('name')
  		@type=Asset.select("assetable_type as name,count(*) as count").group(:assetable_type)
		@asset = Asset.joins(:asset_state).select("asset_states.name as state,count(asset_state_id) as count").group(:state)
		@asset1= Asset.joins(:asset_state).select("asset_states.name as state,assetable_type as type,count(asset_state_id) as count").group(:state,:type)	
		@sfttype=Software.joins(:software_type).select("name,count(software_type_id) as count").group(:name,:software_type_id).order('name')	
		@doctype=Document.joins(:document_type).select("name,count(document_type_id) as count").group(:name,:document_type_id).order('name')
		@comptype =Computer.joins(:computer_category).select("name,count(computer_category_id) as count").group(:name,:computer_category_id).order('name')
		@mobtype= MobileAsset.joins(:device_type).select("name,count(device_type_id) as count").group(:name,:device_type_id).order('name')	
		@othertype=OtherAsset.joins(:asset_type).select("name,count(asset_type_id) as count").group(:name,:asset_type_id).order('name')	
		@sertype=Service.joins(:service_type).select("name,count(service_type_id) as count").group(:name,:service_type_id).order('name')	
  end


end
