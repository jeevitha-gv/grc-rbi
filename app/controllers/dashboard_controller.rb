class DashboardController < ApplicationController
  
  #Audit Calender Page
	def calender
		@audit = current_user.accessible_audits
	end

  # Main Dashboard page
  def index
  end
end
