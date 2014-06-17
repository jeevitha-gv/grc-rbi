class Audit < ActiveRecord::Base

  # associations
  belongs_to :location
  belongs_to :department
  belongs_to :team
  belongs_to :client
  belongs_to :audit_status
  belongs_to :audit_type
  belongs_to :compliance, foreign_key: 'standard_id'
  has_many :nc_questions
  has_many :answers, through: :nc_questions
  has_many :default_compliance_libraries, -> { where(is_leaf: true) }, through: :compliance, source: :compliance_library
  has_many :nc_checklist_recommendations, through: :answers , source: :checklist_recommendations
  has_many :compliance_checklist_recommendations, through: :audit_compliances, source: :checklist_recommendation
  has_many :audit_compliances
  has_many :audit_auditees
  has_many :artifact_answers, through: :audit_compliances
  has_many :auditees, through: :audit_auditees, :source => :user
  belongs_to :auditory, class_name: 'User', foreign_key: 'auditor'
  has_one :skipped_audit_reminder
  has_many :team_users, through: :team, :source => :users
  has_many :audit_operational_weightages
  has_many :compliance_libraries, through: :audit_compliances


  accepts_nested_attributes_for :nc_questions
  accepts_nested_attributes_for :audit_auditees, reject_if: lambda { |a| a[:user_id].blank? }
  accepts_nested_attributes_for :nc_questions, :allow_destroy => true

  COMPLIANCE_TYPES = [["Compliance Audit", "Compliance"], ["NonCompliance Audit", "NonCompliance"]]

  # validations
  validates :title, presence:true
  validates_format_of :title, :with =>/\A(?=.*[a-z])[a-z\d\s]+\Z/i, :if => Proc.new{ |f| !f.title.blank? }
  validates :title, uniqueness:true, :if => Proc.new{ |f| !f.title.blank? }
  validates :title, length: { maximum: 250 }, :if => Proc.new{|f| !f.title.blank? }
  validates :auditor, presence:true
  validates :audit_type_id, presence:true
  validates :compliance_type, presence:true
  validates :standard_id, presence:true, :if => Proc.new{ |f| !f.compliance_type.blank? }
  validates_format_of :issue, :with =>/\A(?=.*[a-z])[a-z\d\s]+\Z/i, :if => Proc.new{ |f| !f.issue.blank? }
  validates :scope, length: { in: 0..250 }, :if => Proc.new{ |f| !f.scope.blank? }
  validates :context, length: { in: 0..250 }, :if => Proc.new{ |f| !f.context.blank? }
  validates :methodology, length: { in: 0..250 }, :if => Proc.new{ |f| !f.methodology.blank? }
  validates :deliverables, length: { in: 0..250 }, :if => Proc.new{ |f| !f.deliverables.blank? }
  validates :objective, length: { in: 0..250 }, :if => Proc.new{ |f| !f.objective.blank? }
  validates :close_reason, length: { in: 0..250 }, :if => Proc.new{ |f| !f.close_reason.blank? }
  validates :observation, length: { in: 0..250 }, :if => Proc.new{ |f| !f.observation.blank? }
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :check_auditees_uniq
  validate :check_auditees_presence
  validate :validate_end_date_before_start_date

  delegate :name, :to => :client, prefix: true, allow_nil: true
  delegate :name, :to => :team, prefix: true, allow_nil: true
  delegate :name, :to => :audit_type, prefix: true, allow_nil: true
  delegate :full_name, :to => :auditory, prefix: true, allow_nil: true
  delegate :email, :to => :auditory, prefix: true, allow_nil: true
  delegate :name, :to => :location, prefix: true, allow_nil: true
  delegate :name, :to => :department, prefix: true, allow_nil: true
  delegate :name, :to => :audit_status, prefix: true, allow_nil: true

  scope :with_status, ->(status_id) { where(audit_status_id: status_id)}

  # mapping do
  #   indexes :_id, :index => :not_analyzed
  #   indexes :title
  #   indexes :context
  #   indexes :observation
  # end

  def answered_compliances
    self.audit_compliances.where(is_answered: true)
  end

  def auditee_response_compliances(user_id)
    self.audit_compliances.joins(:checklist_recommendation).joins("left OUTER join artifact_answers on audit_compliances.id=artifact_answers.audit_compliance_id").where("is_answered = true and  checklist_recommendations.recommendation_completed = true and artifact_answers.responsibility_id=?",user_id).uniq
  end

  def audit_observation_compliances
    self.audit_compliances.joins(:checklist_recommendation).where("is_answered = true and  checklist_recommendations.response_completed = true")
  end

  # Getting all the unanswered Audit compliance for sending reminders
  def unanswered_artifacts
    self.artifact_answers.where("audit_compliances.is_answered=false")
  end

  # Getting all the checklist recommendations for sending reminders
  def unresponsive_recommendation
    self.checklist_recommendations.where("recommendation_completed = true AND response_completed = false")
  end

  # Getting all the non compliance for sending reminders
  def unanswered_nc_questions
    self.nc_questions.where("target_date <= ?" , DateTime.now).select{ |x| x.answers.blank?}
  end

  def answered_ncquestions
    self.nc_questions
  end
  
  def audit_compliances_for_current_user(user_id)
    self.audit_compliances.joins("left OUTER join artifact_answers on audit_compliances.id=artifact_answers.audit_compliance_id").where("artifact_answers.responsibility_id=?",user_id).uniq
  end


  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when '.csv' then Roo::CSV.new(file.path)
    when '.xlsx' then Roo::Excelx.new(file.path)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

# ASC Score measurement
def self.audit_operational_weightage(company,audit)
  over_all_maximum_score = 0
  over_all_total_score = 0
  grouped_audit_compliance = AuditCompliance.joins("join compliance_libraries ON compliance_libraries.id=audit_compliances.compliance_library_id").where("audit_id=?", audit.id).group_by {|x| x.compliance_library.parent.parent_id}

  grouped_audit_compliance.each do |k, v|
    operational_area = OperationalArea.find_or_initialize_by(compliance_library_id: k, company_id: company.id)
    if(operational_area.new_record?)
      operational_area.weightage = 1
      operational_area.company_id = current_company.id
      operational_area.save
    end

      #  Sum of scores of each control
        total_score = v.sum{|x| x.score.level}
        over_all_total_score += total_score

      # Weightage
        weightage = total_score * operational_area.weightage

      # Compliance Percentage Calculation
        # maximum_rating = (v.count * operational_area.weightage).to_f
        maximum_rating = (v.count * 4)
        maximum_score = (maximum_rating * operational_area.weightage).to_f
        over_all_maximum_score += maximum_score
        compliance_percentage = (weightage / maximum_score ) * 100
        rating = get_compliance_rating(compliance_percentage)

      # AuditOperationalWeightage
        AuditOperationalWeightage.create(operational_area_id: operational_area.id, audit_id: audit.id, weightage: weightage, total_score: total_score, percentage: compliance_percentage, rating: rating)
  end
   # total compliance percentage
   total_maximum_score = over_all_maximum_score.to_f
   total_weightage = over_all_total_score.to_f
   total_compliance_percentage = (total_weightage/total_maximum_score) * 100

   audit.update(percentage: total_compliance_percentage)
end

  def checklist_recommendations
    (self.compliance_checklist_recommendations + self.nc_checklist_recommendations).uniq
  end

  # Method to get Compliance Percentage
  def self.get_compliance_rating(compliance_percentage)
    case compliance_percentage
      when compliance_percentage <= 50
        return 1
      when compliance_percentage <= 70
        return 2
      when compliance_percentage <= 90
        return 3
      when compliance_percentage <=100
        return 4
      else
        return 1
    end
  end
  
  def maximum_actual_score
    audit_domains = self.audit_operational_weightages.collect{|x| x.operational_area.compliance_library_name}
    audit_weightage = self.audit_operational_weightages.map(&:weightage)
    audit_percentage = self.audit_operational_weightages.map(&:percentage)
    audit_maximum_score = self.audit_operational_weightages.map(&:maximum_score)
    return audit_domains, audit_weightage, audit_maximum_score, audit_percentage
  end
  
  def audit_users
    audit_users = self.auditees.map(&:full_name)
    audit_users << self.auditory_full_name
    audit_users.compact!
  end
  
  def audit_status_records
    recommendation_completed_status = []
    response_completed_status = []
    observation_completed_status = []
    recommendation_pending_status = []
    response_pending_status = []
    observation_pending_status = []
    checklist_completed_status = []
    checklist_pending_status = []
    self.checklist_recommendations.each do |checklist|
        checklist.recommendation_completed.nil? ? checklist_pending_status << checklist.recommendation_completed  : checklist_completed_status << checklist.recommendation_completed
        checklist.response_completed.nil? ? checklist_pending_status << checklist.response_completed : checklist_completed_status << checklist.response_completed
        checklist.is_published.nil? ? checklist_pending_status << checklist.is_published  : checklist_completed_status << checklist.is_published
        recommendation_completed_status = ChecklistRecommendation.where('recommendation_completed= ?',true).count
        recommendation_pending_status = ChecklistRecommendation.all.count - recommendation_completed_status
        response_completed_status = ChecklistRecommendation.where('response_completed= ?',true).count
        response_pending_status = ChecklistRecommendation.all.count - response_completed_status
        observation_completed_status = ChecklistRecommendation.where('is_published= ?',true).count
        observation_pending_status = ChecklistRecommendation.all.count - observation_completed_status
    end
    return checklist_completed_status.count, checklist_pending_status.count, recommendation_completed_status, recommendation_pending_status, observation_completed_status, observation_pending_status, response_completed_status, response_pending_status
end

  private
  def check_auditees_uniq
    if self.audit_auditees.present?
      check_user_id = audit_auditees.size == audit_auditees.collect{|x| x.user_id}.uniq.size
      errors.add(:auditees, ("Please select unique auditees")) if check_user_id == false
    end
  end

  def check_auditees_presence
    self.errors[:auditees] = MESSAGES['audit']['failure']['auditee_blank'] unless audit_auditees.present?
  end

  def validate_end_date_before_start_date
    if end_date && start_date
      self.errors[:end_date] = MESSAGES['audit']['failure']['start_date_before_end_date'] if end_date < start_date
    end
  end
end
