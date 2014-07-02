class MgmtReview < ActiveRecord::Base

	# Associations
	belongs_to :risk
	belongs_to :review
	belongs_to :reviewer, class_name: "User", foreign_key: :reviewer
	belongs_to :next_step
	has_one :comment , as: :commentable, class_name: "Comment"
	accepts_nested_attributes_for :comment, :allow_destroy => true


	delegate :name, to: :review, prefix: true, allow_nil: :true
	delegate :name, to: :next_step, prefix: true, allow_nil: :true

	# callbacks
  after_create :notify_risk_users_about_mgmt_reviews

  def notify_risk_users_about_mgmt_reviews
    risk = self.risk
    users_email = []
    subject_array = ["mgmt_review_owner", "mgmt_review_mitigator", "mgmt_review_reviewer", "mgmt_review_submitor"]
    users_email << risk.risk_owner.email << risk.risk_mitigator.email << risk.risk_reviewer.email << risk.submitor.email
    users_email.each_with_index do |email, index|
      RiskMailer.delay.notify_users_about_risk(risk, email, subject_array[index], name="mgmt_review")
    end
  end
end