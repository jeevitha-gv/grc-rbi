class ControlChart < ActiveRecord::Base
  # Validations
  validates :name, presence:true
  validates :x_axis, presence:true
  validates :y_axis, presence:true
  validates :chart_type, presence:true

  #Associations
  belongs_to :company

  def self.update_chart_order(order)
    order.each_with_index do |id, index|
      control_chart = ControlChart.find_by_id(id)
      control_chart.update(:order => index)
  end
    end

end
