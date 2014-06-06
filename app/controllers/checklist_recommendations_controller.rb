class ChecklistRecommendationsController < ApplicationController
	 

	 def new
	 	@audit = Audit.find(params[:id]) # need to change with permission
	  @controls = @audit.answered_compliances
	 	@checklist_recommendation = ChecklistRecommendation.new
	 	@score = Score.all
	 end


	 def create
	  @checklist_recommendation = ChecklistRecommendation.new(checklist_params)
	  
	   if @checklist_recommendation.save
	 		redirect_to @checklist_recommendation
	 	else
	 		render 'new'
	 
	  	end
	 end
	
	def auditee_response

	end

	def audit_observation

	end

	def update_individual_score

	 checklist = ChecklistRecommendation.where('checklist_id= ? AND checklist_type= ?',params[:checklist_id], params[:checklist_type]).first
	if checklist.nil?
	
   @checklist_recommendation = ChecklistRecommendation.new(checklist_params)
   @checklist_recommendation.save
	else
		# p	checklist = ChecklistRecommendation.where('checklist_id= ? AND checklist_type= ?',params[:checklist_id], params[:checklist_type]).first
			checklist.update(checklist_params)
	end
end

	private
	  def checklist_params
	    params.require(:checklist_recommendation).permit(:checklist_id, :checklist_type, :auditee_id, :recommendation, :reason, :corrective, :preventive, :closure_date, :recommendation_priority_id, :recommendation_severity_id, :response_priority_id, :response_severity_id, :recommendation_status_id, :response_status_id, :dependent_recommendation, :blocking_recommendation, :observation)
	  end
end

