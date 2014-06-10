class DashboardController < ApplicationController
	
	def calender
		@audit =Audit.where('id=?', 4)
	end
end
