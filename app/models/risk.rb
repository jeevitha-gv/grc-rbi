class Risk < ActiveRecord::Base

	# Associations
	has_one :mgmt_review
	has_many :closures
	has_one :control_measure
	has_one :risk_scoring
	has_one :mitigation
  has_one :attachment, as: :attachable
	belongs_to :risk_status
	belongs_to :compliance
	belongs_to :location
	belongs_to :company
	belongs_to :risk_owner, class_name: 'User', foreign_key: 'owner'
	belongs_to :risk_mitigator, class_name: 'User', foreign_key: 'mitigator'
	belongs_to :risk_reviewer, class_name: 'User', foreign_key: 'reviewer'
	belongs_to :risk_category, class_name: 'RiskCategory', foreign_key: 'category_id'
	belongs_to :team
	belongs_to :department
	belongs_to :compliance_library
	belongs_to :technology
	belongs_to :risk_model
	belongs_to :submitor, class_name: 'User', foreign_key: 'submitted_by'
	belongs_to :project
	belongs_to :risk_approval_status, foreign_key: 'risk_approval_status_id'

  # Validations
  validates :subject, presence:true, length: { in: 0..250 }, :if => Proc.new{ |f| !f.subject.blank? }
  # validates :compliance_library_id, presence:true
  validates :assessment, presence:true
  validates :notes, length: { in: 0..250 }
  validates :reference, presence:true, length: { in: 0..250 }, :if => Proc.new{ |f| !f.subject.blank? }
  validates :compliance_id, presence:true
  validates :category_id, presence:true
  validates :technology_id, presence:true
  validates :owner, presence:true
  validates :mitigator, presence:true
  # validates :reviewer, presence:true
  validates :submitted_by, presence:true


	delegate :name, to: :risk_status, prefix: true, allow_nil: true
	delegate :user_name, to: :risk_owner, prefix: true, allow_nil: true
	delegate :scoring_type, to: :risk_scoring, prefix: true, allow_nil: true
	delegate :calculated_risk, to: :risk_scoring, prefix: true, allow_nil: true
	delegate :custom_value, to: :risk_scoring, prefix: true, allow_nil: true
	delegate :name, to: :location, prefix: true, allow_nil: true
	delegate :name, to: :team, prefix: true, allow_nil: true
	delegate :name, to: :compliance, prefix: true, allow_nil: true
	delegate :name, to: :risk_category, prefix: true, allow_nil: true
	delegate :name, to: :technology, prefix: true, allow_nil: true
	delegate :name, to: :risk_model, prefix: true, allow_nil:true


	accepts_nested_attributes_for :mitigation
  accepts_nested_attributes_for :control_measure
  accepts_nested_attributes_for :risk_scoring

  # callbacks
  # after_create :notify_risk_users

	def self.risk_rating(company_id)
		high_risk = RiskReviewLevel.where("name= ? AND company_id= ?",'HIGH',company_id).first
		medium_risk = RiskReviewLevel.where("name= ? AND company_id= ?",'MEDIUM',company_id).first
		low_risk = RiskReviewLevel.where("name= ? AND company_id= ?",'LOW',company_id).first
		return high_risk, medium_risk, low_risk
	end

	def notify_risk_users
		users_email = []
		subject_array = ["Your risk has been successfully created and assigned", "A new risk has been assigned to you for mitigation"]
		users_email << self.risk_owner.email << self.risk_mitigator.email
    users_email.each_with_index do |email, index|
    	RiskMailer.delay.notify_users_about_risk(self, email, subject_array[index], name="risk")
    end
  end
end