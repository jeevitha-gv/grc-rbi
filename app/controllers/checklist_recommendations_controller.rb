class ChecklistRecommendationsController < ApplicationController
	 

	 def new
			@audit = Audit.find_by_id(params[:id]) # need to change with permission
			@controls = @audit.answered_compliances
			@checklist_recommendation = ChecklistRecommendation.new
			@score = Score.all
	 end


	def create
		@checklist_recommendation = ChecklistRecommendation.new(checklist_params)
		checklist_params = @checklist_recommendation.audit_checklist(params)
			checklist_params.each do |check|
				checklist = {}
				checklist[:checklist_recommendation] = check
				@checklist_recommendation = ChecklistRecommendation.where('checklist_id= ? AND checklist_type= ?',checklist[:checklist_recommendation][:checklist_id], checklist[:checklist_recommendation][:checklist_type]).first
				if @checklist_recommendation.nil?	
						score = check[:score]
						check.delete("score") 
					@checklist_recommendation = ChecklistRecommendation.new(check)
					 @checklist_recommendation.recommendation_completed = true unless params[:commit] == 'Save Draft'
					if @checklist_recommendation.save
											@checklist_recommendation.checklist.update_attributes(:score_id => score)
						@checklist_recommendation
					else
						render 'new'
					end
				else
					@checklist_recommendation.recommendation_completed = true unless params[:commit] == 'Save Draft'
					@checklist_recommendation.checklist.update(:score_id => checklist[:checklist_recommendation][:score])
					checklist[:checklist_recommendation].delete("score") 
					@checklist_recommendation.update(checklist[:checklist_recommendation])
				end
			end
			redirect_to @checklist_recommendation
	 end
	
	def auditee_response

	end

	def audit_observation

	end

	def update_individual_score
		checklist_recommendation = ChecklistRecommendation.where('checklist_id= ? AND checklist_type= ?',params[:checklist_recommendation][:checklist_id], params[:checklist_recommendation][:checklist_type]).first
		score = params[:checklist_recommendation][:score]
		params[:checklist_recommendation].delete("score") 
	if checklist_recommendation.nil?
   @checklist_recommendation = ChecklistRecommendation.new(checklist_params)
   @checklist_recommendation.save
	else
		checklist_recommendation.update(checklist_params)
	end
end

	private
	  def checklist_params
	    params.require(:checklist_recommendation).permit(:checklist_id, :checklist_type, :auditee_id, :recommendation, :reason, :corrective, :preventive, :closure_date, :recommendation_priority_id, :recommendation_severity_id, :response_priority_id, :response_severity_id, :recommendation_status_id, :response_status_id, :dependent_recommendation, :blocking_recommendation, :observation)
	  end
			def audit_compliance_params
	    params.require(:audit_compliances).permit(:compliance_library_id, :audit_id, :score_id, :is_answered)
	  end
end

