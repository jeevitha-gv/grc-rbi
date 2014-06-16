class DashboardController < ApplicationController
	before_filter :authenticate_user!

	def calender
		@audit = current_user.accessible_audits
	end

  def index

  end
end
