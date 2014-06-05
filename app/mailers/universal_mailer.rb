class UniversalMailer < ActionMailer::Base

  default from: "noreply@fixrnix.in"

  def notify_auditor_about_audit(audit)
  	@audit = audit
  	mail(:to => User.where(:id => audit.auditor).last.email, :subject => "Your Audit has been successfully created")
  end

  def notify_auditees_about_audit(audit)
  	@audit = audit
  	mail(:to => User.where(:id => (audit.audit_auditees.map(&:user_id))).map(&:email), :subject => "You have been invited to an audit")
  end

  def notify_auditee_that_checklist_is_prepared(audit)
    @audit = audit
    mail(:to => User.where(:id => audit.audit_auditees).last.email, :subject => "Checklist has been prepared for Audit")
  end

  def notify_auditor_that_auditee_has_answered(audit)
    @audit = audit
    mail(:to => User.where(:id => audit.auditor).last.email, :subject => "All auditees has answered your Checklist")
  end

  def notify_auditee_about_recommendations(audit)

  end

  def notify_auditor_about_responses(audit)

  end

  def notify_everyone_about_observations(audit)

  end

end
