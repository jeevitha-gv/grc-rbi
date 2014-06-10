class ChecklistRecommendation < ActiveRecord::Base
	# belongs_to :auditee_id, :class_name => "ArtifactAnswer"	
	belongs_to :rec_priority, :class_name =>"Priority", foreign_key: :recommendation_priority
	belongs_to :rec_severity, :class_name =>"Priority", foreign_key: :recommendation_severity
	belongs_to :response_priority, :class_name =>"Priority"
	belongs_to :response_severity, :class_name =>"Priority"
	belongs_to :recommendation_severity, :class_name =>"Priority"
	belongs_to :recommendation_priority, :class_name =>"Priority"
	belongs_to :recommendation_status, :class_name =>"RecommendationStatus"
	belongs_to :response_status, :class_name => "ResponseStatus"
	belongs_to :response_status
	belongs_to :dependent_checklist, :class_name => "ChecklistRecommendation", foreign_key: "dependent_recommendation"
	belongs_to :blocking_checklist, :class_name => "ChecklistRecommendation", foreign_key: "blocking_recommendation"
	belongs_to :checklist, polymorphic: true
	has_many :attachments , as: :attachable
	has_many :comments , as: :commentable
	
	#validation
	validates :recommendation, presence: true
	validates :reason, presence: true
	validates :recommendation_priority_id, presence: true
	validates :recommendation_severity_id, presence: true
	validates :closure_date, presence: true
	validates :recommendation_status_id, presence: true
	validates :preventive, presence: true, :if => Proc.new{|f|  f.recommendation_completed == true}
	validates :corrective, presence: true, :if => Proc.new{|f| f.recommendation_completed == true}
	validates :response_status_id, presence: true, :if => Proc.new{|f| f.recommendation_completed == true}
	validates :response_priority_id, presence: true, :if => Proc.new{|f| f.recommendation_completed == true}
	validates :response_severity_id, presence: true, :if => Proc.new{|f| f.recommendation_completed == true}
	validates :observation, presence: true, :if => Proc.new{|f| f.response_completed == true}
	validates :is_implemented, presence: true, :if => Proc.new{|f| f.response_completed == true}
	validates :recommendation_status_id, presence: true
	
	
	#~ delegate :audit_id, to: :checklist_recommendation, prefix: true, allow_nil: true
	#~ accepts_nested_attributes_for :attachment, reject_if: lambda { |a| a[:attachment_file].blank? }, allow_destroy: true
	
	def audit_checklist(checklist_input)
		checklist_params =[]
			checklist_recommendation_id = checklist_input[:checklist_recommendation].collect {|k,v| v}
			checklist_recommendation_id.each do |record|
			checklist_params << record
		end
		return checklist_params
	end
end
