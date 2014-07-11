class DashboardChart < ActiveRecord::Base
	
	#Association
	belongs_to :company
	
	def self.update_chart_order(order)
		chart_order = order.split('|')
		chart_order.each_with_index do |id, index|
			dashboard_chart = DashboardChart.find_by_id(id)
			dashboard_chart.update(:order => index)
		end
	end
end
