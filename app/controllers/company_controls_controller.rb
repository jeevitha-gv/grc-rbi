class CompanyControlsController < ApplicationController
  
layout 'policy_layout'

  # Index 
  def index
    @company_controls = CompanyControl.all
  end

  # Create New Control
  def new
    @control = CompanyControl.new
  end

  # Create POST method
  def create
    @control = CompanyControl.new(control_params)
    if @control.save
      redirect_to company_controls_path, :flash => { :notice => "Control has been added successfully" }
    else
      render "new"
    end
  end

  # Edit the existing Control
  def edit
    @control = CompanyControl.find(params[:id])
  end

  # Update POST method
  def update
    @control = CompanyControl.find(params[:id])
     if @control.update_attributes(control_params)
      redirect_to company_controls_path, :flash => { :notice => "Control has been updated successfully" }
    else
      render "edit"
    end
  end

  # Show Individiual Control
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

  # Export the controls
  def export
    @controls = CompanyControl.all
    respond_to do |format|
      format.pdf do
        @pdf = (render_to_string pdf: "PDF", template: "company_controls/export.pdf.erb", layout: 'layouts/pdf.html.erb', encoding: "UTF-8", disposition: "inline")
        send_data(@pdf, type: "application/pdf", filename: "Control-Report")
      end
      format.csv { send_data @controls.to_csv }
      format.xls
    end
  end


  private

  # parameters
  def control_params
    params.require(:company_control).permit(:title,:control_classification_id,:purpose_id,:control_state_id,:control_freq_id,:standard_id,:company_id,:description)
  end

end
