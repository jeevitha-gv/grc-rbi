class DashboardChart < ActiveRecord::Base
	
	#Association
	belongs_to :company
	
	def self.update_chart_order(order)
		p 4444444444
		#~ current_company.dashboard_charts.each do ||
		p chart_order = order.split('|')
		chart_order.each_with_index do |id, index|
			p 6666666666
			p index
			p id
			dashboard_chart = DashboardChart.find_by_id(id)
			dashboard_chart.update(:order => index)
		end
	end
end
