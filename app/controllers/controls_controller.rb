class ControlsController < ApplicationController
before_filter :check_company_disabled, :company_module_access_check
layout 'control_layout'
	def new
    	@control = Control.new
  	end

   def index
    if params[:stage].present?
      @controls = current_user.controls_stage(params)
    else
      @controls = current_user.accessible_controls
    end
    
  end

 
  	def edit
    	@control = Control.find(params[:id])
    	control_initializers( @control.classification_control_id, @control.purpose_control_id, @control.owning_group_id)
  	end

  def create
    @control = Control.create(control_params)
    #@incident.set_incident_status(@incident, params[:commit])

    if @control.save
      flash[:notice] = "The control was successfully created"
      redirect_to controls_path
    else
      
      redirect_to new_control_path
    end
  end

  def update
    @control = Control.find(params[:id])
    # @control.set_incident_status(@control, params[:commit]) if params[:commit] == "Initiate control"
    if @control.update_attributes(control_params)
      redirect_to edit_control_path
    else
      incident_initializers( @control.owner, @control.owner_delegate, @control.classification_control_id,@control.purpose_control_id,@control.owning_group_id,@control.control_regulation_id,@control.data_purpose_id,@control.control_status_id,@control.fraud_related_id,@control.team_id)
      render 'edit'
    end
  end
  
  def show
  
  end

  def control_all
    if params[:stage].present?
      @controls = current_user.controls_stage(params)
    else
      @controls = current_user.accessible_controls
    end
  end
  
  # def update
  #   @control = Incident.find(params[:id])
  #   @incident.set_incident_status(@incident, params[:commit]) if params[:commit] == "Initiate incident"
  #   if @incident.update_attributes(incident_params)
  #     redirect_to edit_incident_path
  #   else
  #     incident_initializers( @incident.department_id, @incident.team_id, @incident.request_type_id,@incident.incident_status_id,@incident.sub_category_id,@incident.resolution_id)
  #     render 'edit'
  #   end
  # end

  # def show
  #     @incident = Incident.find(params[:id])
  #     # @incident=Evaluate.find(params[:id])
  #     respond_to do |format|
  #     format.html
  #     format.pdf do
  #     @pdf = (render_to_string pdf: "PDF", template: "incidents/show.pdf.erb", layout: 'layouts/pdf.html.erb', encoding: "UTF-8")
  #       send_data(@pdf, type: "application/pdf", filename: @incident.title)
  #     end
  #   end
  # end


  private
  
  def control_params
    params.require(:control).permit(:controlid, :name, :owner, :description,:owner_delegate, :objective, :maintenance_metric_description, :note, :classification_control_id, :purpose_control_id, :owning_group_id, :control_regulation_id)
  end


  def control_initializers(classification_control_id = nil, purpose_control_id = nil,owning_group_id = nil)
  end


end
