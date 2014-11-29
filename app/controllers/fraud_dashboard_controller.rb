class FraudDashboardController < ApplicationController
	layout 'fraud_layout'
	
  def index
		@fraud= Fraud.joins(:fraud_status).select("fraud_statuses.name as state,count(fraud_status_id) as count").group(:state)	
		@fraud1= Fraud.joins(:location).select("name ,count(location_id) as count").group(:name, :location_id).order('name')		
  end

end
