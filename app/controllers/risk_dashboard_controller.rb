class RiskDashboardController < ApplicationController

  before_filter :company_module_access_check
  before_filter :check_plan_expire

  def index
    @risk_chart = RiskChart.new
    @charts = current_company.risk_charts.sort_by{|x| x.order}
    @risks = Risk.all # Need to modify
  end

  def create
    @risk_chart = RiskChart.new(risk_chart_params)
    @dashboar_max_order = current_company.risk_charts.empty? ? 1 : current_company.risk_charts.map(&:order).max
    @risk_chart.order = @dashboar_max_order+1
      @charts = current_company.risk_charts 		if @risk_chart.save
    respond_to :js
  end

  def update
    order_arr = params[:order].split(",")
    RiskChart.update_chart_order(order_arr)
    respond_to :js
  end

  def destroy
    @chart = RiskChart.find_by_id(params[:id])
    @chart.destroy
    respond_to :js
  end

  private

  def risk_chart_params
    params.require(:risk_chart).permit(:id, :name, :company_id, :x_axis, :y_axis, :chart_type, :order)
  end


end
