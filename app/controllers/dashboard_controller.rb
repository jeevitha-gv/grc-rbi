class DashboardController < ApplicationController
	
	def calender
		@audit = current_user.accessible_audits
	end

  def index

  end
end
