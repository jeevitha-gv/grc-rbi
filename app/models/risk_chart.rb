class RiskChart < ActiveRecord::Base

  # Validations
  validates :name, presence:true
  validates :x_axis, presence:true
  validates :y_axis, presence:true
  validates :chart_type, presence:true

  #Associations
  belongs_to :company

  def self.update_chart_order(order)
    order.each_with_index do |id, index|
      risk_chart = RiskChart.find_by_id(id)
      risk_chart.update(:order => index)
  end
    end

end
