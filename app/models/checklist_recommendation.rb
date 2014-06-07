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
	
	#validation
   validates :recommendation, presence: true
   validates :reason, presence: true
   validates :response_priority_id, presence: true
   validates :response_priority_id, presence: true
   validates :response_severity_id, presence: true
   validates :closure_date, presence: true
   validates :recommendation_status_id, presence: true
	
	def audit_checklist(checklist_input)
		checklist_params =[]
			checklist_recommendation_id = checklist_input[:checklist_recommendation].collect {|k,v| v}
			checklist_recommendation_id.each do |record|
			checklist_params << record
		end
		return checklist_params
	end
end
