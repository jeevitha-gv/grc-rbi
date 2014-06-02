class Audit < ActiveRecord::Base

  # associations
  has_many :nc_questions
  belongs_to :location
  belongs_to :department
  belongs_to :team
  belongs_to :client
  belongs_to :audit_status
  has_many :audit_compliances  
  accepts_nested_attributes_for :nc_questions


  # validations
  validates :title, presence:true
  validates_format_of :title, :with =>/\A(?=.*[a-z])[a-z\d\s]+\Z/i, :if => Proc.new{ |f| !f.title.blank? }
  validates :title, uniqueness:true, :if => Proc.new{ |f| !f.title.blank? }
  validates_format_of :issue, :with =>/\A(?=.*[a-z])[a-z\d\s]+\Z/i, :if => Proc.new{ |f| !f.issue.blank? }
  validates :scope, length: { in: 4..50 }, :if => Proc.new{ |f| !f.scope.blank? }
  validates :context, length: { in: 4..50 }, :if => Proc.new{ |f| !f.context.blank? }
  validates :methodology, length: { in: 4..50 }, :if => Proc.new{ |f| !f.methodology.blank? }
  validates :deliverables, length: { in: 4..50 }, :if => Proc.new{ |f| !f.deliverables.blank? }
  validates :objective, length: { in: 4..50 }, :if => Proc.new{ |f| !f.objective.blank? }
  validates :close_reason, length: { in: 4..50 }, :if => Proc.new{ |f| !f.close_reason.blank? }
  validates :observation, length: { in: 4..50 }, :if => Proc.new{ |f| !f.observation.blank? }

end
