class Mitigation < ActiveRecord::Base
  belongs_to :risk
  belongs_to :planning_strategy
  belongs_to :mitigation_effort
  belongs_to :submitor, :class_name => "User", foreign_key: :submitted_by

  # callbacks
  after_create :notify_risk_users_about_mitigation

  #validation
  validates :current_solution, presence:true, length: { in: 0..250 }, :if => Proc.new{ |f| !f.current_solution.blank? }
  validates :security_requirements, presence:true, length: { in: 0..250 }, :if => Proc.new{ |f| !f.security_requirements.blank? }
  validates :security_recommendations, presence:true, length: { in: 0..250 }, :if => Proc.new{ |f| !f.security_recommendations.blank? }

  def notify_risk_users_about_mitigation
    risk = self.risk
    users_email = []
    subject_array = ["Mitigation plan has been added for your risk", "Your mitigation plan has been added & submitted for review", "A new risk has been assigned to you for management review", "Mitigation plan has been added for your risk"]
    users_email << risk.risk_owner.email << risk.risk_mitigator.email << risk.risk_reviewer.email << risk.submitor.email
    users_email.each_with_index do |email, index|
      RiskMailer.delay.notify_users_about_risk(risk, email, subject_array[index], name="mitigation")
    end
  end
end