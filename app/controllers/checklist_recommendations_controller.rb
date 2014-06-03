class ChecklistRecommendationsController < ApplicationController
	 

	 def new
	 	@audit = Audit.first
	 	@checklist_recommendation = ChecklistRecommendation.new
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

	private

	  def checklist_params
	    params.require(:checklist_recommendation).permit(:checklist_id, :checklist_type, :auditee_id,:recommendation,:reason, :corrective, :preventive, :closure_date, :recommendation_priority_id, :recommendation_severity_id, :response_priority_id, :response_severity_id, :recommendation_status_id, :response_status_id, :dependent_recommendation, :blocking_recommendation, :observation)
	  end
end

