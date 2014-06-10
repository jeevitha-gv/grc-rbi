class Audit < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks

  # associations
  belongs_to :location
  belongs_to :department
  belongs_to :team
  belongs_to :client
  belongs_to :audit_status
  belongs_to :audit_type
  has_many :nc_questions
  has_many :checklist_recommendations, through: :audit_compliances
  has_many :audit_compliances
  has_many :audit_auditees
  has_many :artifact_answers, through: :audit_compliances
  has_many :auditees, through: :audit_auditees, :source => :user
  belongs_to :auditory, class_name: 'User', foreign_key: 'auditor'
  has_one :skipped_audit_reminder
  has_many :team_users, through: :team, :source => :users


  accepts_nested_attributes_for :nc_questions
  accepts_nested_attributes_for :audit_auditees, reject_if: lambda { |a| a[:user_id].blank? }
  accepts_nested_attributes_for :nc_questions, :allow_destroy => true

  # validations
  validates :title, presence:true
  validates_format_of :title, :with =>/\A(?=.*[a-z])[a-z\d\s]+\Z/i, :if => Proc.new{ |f| !f.title.blank? }
  validates :title, uniqueness:true, :if => Proc.new{ |f| !f.title.blank? }
  #validates :auditor, presence:true
  validates :audit_type_id, presence:true
  validates :standard_id, presence:true, :if => Proc.new{ |f| !f.compliance_type.blank? }
  validates_format_of :issue, :with =>/\A(?=.*[a-z])[a-z\d\s]+\Z/i, :if => Proc.new{ |f| !f.issue.blank? }
  validates :scope, length: { in: 4..50 }, :if => Proc.new{ |f| !f.scope.blank? }
  validates :context, length: { in: 4..50 }, :if => Proc.new{ |f| !f.context.blank? }
  validates :methodology, length: { in: 4..50 }, :if => Proc.new{ |f| !f.methodology.blank? }
  validates :deliverables, length: { in: 4..50 }, :if => Proc.new{ |f| !f.deliverables.blank? }
  validates :objective, length: { in: 4..50 }, :if => Proc.new{ |f| !f.objective.blank? }
  validates :close_reason, length: { in: 4..50 }, :if => Proc.new{ |f| !f.close_reason.blank? }
  validates :observation, length: { in: 4..50 }, :if => Proc.new{ |f| !f.observation.blank? }
  validate :check_auditees_uniq
  validate :check_auditees_presence

  delegate :name, :to => :client, prefix: true, allow_nil: true
  delegate :name, :to => :audit_type, prefix: true, allow_nil: true
  delegate :full_name, :to => :auditory, prefix: true, allow_nil: true

  scope :with_status, ->(status_id) { where(audit_status_id: status_id)}

  mapping do
    indexes :_id, :index => :not_analyzed
    indexes :title
    indexes :context
    indexes :observation
  end

  def answered_compliances
    self.audit_compliances.where(is_answered: true).map(&:compliance_library)
  end
  
  def auditee_response_compliances
    self.audit_compliances.where(is_answered: true).collect{|x| x.checklist_recommendations.where('recommendation_completed= ?',true)}.flatten
  end
  
  def audit_observation_compliances
    self.audit_compliances.where(is_answered: true).collect{|x| x.checklist_recommendations.where('response_completed= ?',true)}.flatten
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


  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when '.csv' then Roo::CSV.new(file.path)
    when '.xlsx' then Roo::Excelx.new(file.path)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

  def self.search(params)
    tire.search(load: true) do
      query { string params[:query], default_operator: "AND" } if params[:query].present?
    end
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
end
