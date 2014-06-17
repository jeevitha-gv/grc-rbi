class ChecklistRecommendation < ActiveRecord::Base
	attr_accessor :is_checklist_new, :last_step
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
	belongs_to :auditee, class_name: 'User', foreign_key: 'auditee_id'
	has_one :remark , as: :commentable, class_name: "Comment"
    
    before_create :check_for_published
    before_save :check_for_published

	#validation
	validates :recommendation, presence: true
	validates :reason, presence: true
	validates :recommendation_priority_id, presence: true
	validates :recommendation_severity_id, presence: true
	validates :closure_date, presence: true
	validates :recommendation_status_id, presence: true
	validates :preventive, presence: true, :if => Proc.new{|f|  f.recommendation_completed == true && f.is_checklist_new != true}
	validates :corrective, presence: true, :if => Proc.new{|f| f.recommendation_completed == true && f.is_checklist_new != true}
	validates :response_status_id, presence: true, :if => Proc.new{|f| f.recommendation_completed == true && f.is_checklist_new != true}
	validates :response_priority_id, presence: true, :if => Proc.new{|f| f.recommendation_completed == true && f.is_checklist_new != true}
	validates :response_severity_id, presence: true, :if => Proc.new{|f| f.recommendation_completed == true && f.is_checklist_new != true}
	validates :observation, presence: true, :if => Proc.new{|f| f.recommendation_completed == true && f.response_completed == true && f.is_checklist_new != true}
	validates :is_implemented, presence: true, :if => Proc.new{|f| f.recommendation_completed == true &&  f.response_completed == true && f.is_checklist_new != true}
	validates :recommendation_status_id, presence: true


	delegate :name, :to => :recommendation_priority, prefix: true, allow_nil: true
	delegate :name, :to => :recommendation_priority, prefix: true, allow_nil: true
	delegate :name, :to => :recommendation_status, prefix: true, allow_nil: true
	delegate :name, :to => :response_status, prefix: true, allow_nil: :true
    delegate :name, to: :response_priority, prefix: true, allow_nil: :true
	delegate :comment, to: :remark, prefix: true, allow_nil: :true



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

 # after_create :notify_auditee_about_recommendation
 #  after_update :notify_auditor_about_response
 #  after_update :notify_auditee_about_observation

  def notify_auditee_about_recommendation
  	if self.checklist.audit.compliance_type == 'AuditCompliance'
    	UniversalMailer.notify_auditee_about_recommendations(self).deliver
    else
    	UniversalMailer.notify_auditee_about_nc_recommendations(self).deliver
    end

  end

  def notify_auditor_about_response
  	if self.preventive? && self.corrective? && self.response_status_id?
  		if self.checklist.audit.compliance_type == 'Compliance'
  			UniversalMailer.notify_auditor_about_responses(self).deliver
  		else
  			UniversalMailer.notify_auditor_about_nc_responses(self).deliver
  		end
  	end
  end

  def notify_auditee_about_observation
    if self.observation?
      UniversalMailer.notify_auditee_about_observations(self).deliver
    end
  end

  def check_for_published
  	if(self.last_step)
  		return true
  	elsif(self.is_published)
  		return false
  	end
  end

end
