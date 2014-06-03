class ChecklistRecommendation < ActiveRecord::Base
	# belongs_to :auditee_id, :class_name => "ArtifactAnswer"	
	belongs_to :rec_priority, :class_name =>"Priority", foreign_key: :recommendation_priority
	belongs_to :rec_severity, :class_name =>"Priority", foreign_key: :recommendation_severity
	belongs_to :response_priority, :class_name =>"Priority"
	belongs_to :response_severity, :class_name =>"Priority"
	belongs_to :recommendation_severity, :class_name =>"Priority"
	belongs_to :recommendation_status
	belongs_to :response_status
	belongs_to :dependent_recommendation, :class_name => "ChecklistRecommendation"
	belongs_to :blocking_recommendation, :class_name => "ChecklistRecommendation"
	belongs_to :checklist, polymorphic: true

end
