class ChecklistRecommendation < ActiveRecord::Base
	belongs_to :cheklist_id
	belongs_to :auditee_id, :class_name => "User"
	belongs_to :recommendation_priority, :class_name =>"Priority"
	belongs_to :recommendation_severity, :class_name =>"Priority"
	belongs_to :response_priority, :class_name =>"Priority"
	belongs_to :response_severity, :class_name =>"Priority"
	belongs_to :recommendation_severity, :class_name =>"Priority"
	belongs_to :recommendation_status
	belongs_to :response_status
	belongs_to :dependent_recommendation, :class_name => "ChecklistRecommendation"
	belongs_to :blocking_recommendation, :class_name => "ChecklistRecommendation"

end
