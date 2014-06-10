class DashboardController < ApplicationController
	
	def calender
		@audit =Audit.where('id=?', 4)
	end
	
  def index  	
  	@audit_status = Audit.joins( :audit_status).select("name as status,count(audit_status_id) as count").group(:name)
  	@audit_locations = Audit.joins( :location).select("name ,count(location_id) as count").group(:name)
  end
end
