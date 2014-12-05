class ControlDashboardController < ApplicationController

  before_filter :company_module_access_check
  before_filter :check_plan_expire
  layout 'control_layout'

  def index
    @control_chart = ControlChart.new
    @charts = current_company.control_charts.sort_by{|x| x.order}
    @controls = Control.all # Need to modify
  end

  def create
    @control_chart = ControlChart.new(control_chart_params)
    @dashboar_max_order = current_company.control_charts.empty? ? 1 : current_company.control_charts.map(&:order).max
    @control_chart.order = @dashboar_max_order+1
      @charts = current_company.control_charts 		if @control_chart.save
    respond_to :js
  end

  def update
    order_arr = params[:order].split(",")
    ControlChart.update_chart_order(order_arr)
    respond_to :js
  end

  def destroy
    @chart = ControlChart.find_by_id(params[:id])
    @chart.destroy
    respond_to :js
  end

  private

  def control_chart_params
    params.require(:control_chart).permit(:id, :name, :company_id, :x_axis, :y_axis, :chart_type, :order)
  end


end
