class ChecklistRecommendationsController < ApplicationController
 def new
 	end
 def create

 	@checklist_recommendation = ChecklistRecommendation.new(params[:checklist_recommendation])
 	@checklist_recommendation.save
 	redirect_to @checklist_recommendation
 end
end
