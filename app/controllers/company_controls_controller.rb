class CompanyControlsController < ApplicationController
  
layout 'policy_layout'

  def index
    @control= CompanyControl.all
  end

  def new
    @control = CompanyControl.new
  end

  def edit
    @control = CompanyControl.find(params[:id])
  end

  def update
    @control = CompanyControl.find(params[:id])
     if @control.update_attributes(control_params)
      redirect_to company_controls_path
    else
      render "new"
    end
  end

  def show
    @control = CompanyControl.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf do
        @pdf = (render_to_string pdf: "PDF", template: "company_controls/show.pdf.erb", layout: 'layouts/pdf.html.erb', encoding: "UTF-8")
        send_data(@pdf, type: "application/pdf", filename: @control.title)
      end
    end
  end

  def create
    @control = CompanyControl.new(control_params)
    if @control.save
      redirect_to company_controls_path
    else
      render "new"
    end
  end

  # parameters
  def control_params
    params.require(:company_control).permit(:title,:control_classification_id,:purpose_id,:control_state_id,:control_freq_id,:standard_id,:company_id,:description)
  end

end
