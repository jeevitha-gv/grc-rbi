class Audit < ActiveRecord::Base

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
  has_many :auditees, through: :audit_auditees, :class_name=>"User", :foreign_key => "user_id"

  accepts_nested_attributes_for :nc_questions
  accepts_nested_attributes_for :audit_auditees, reject_if: lambda { |a| a[:user_id].blank? }

  # validations
  validates :title, presence:true
  validates_format_of :title, :with =>/\A(?=.*[a-z])[a-z\d\s]+\Z/i, :if => Proc.new{ |f| !f.title.blank? }
  validates :title, uniqueness:true, :if => Proc.new{ |f| !f.title.blank? }
  validates :auditor, presence:true
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


  private
  def check_auditees_uniq
    check_user_id = audit_auditees.size == audit_auditees.collect{|x| x.user_id}.uniq.size
    errors.add(:auditees, ("Please select unique auditees")) if check_user_id == false
  end

  def check_auditees_presence
    errors.add(:auditees, ("Please select auditee")) unless audit_auditees.present?
  end
end