class UniversalMailer < ActionMailer::Base

  default from: "noreply@fixrnix.in"

  def notify_auditor_about_audit(audit)
  	@audit = audit
  	mail(:to => User.where(:id => audit.auditor).last.email, :subject => "Your Audit has been successfully created")
  end

  def notify_auditees_about_audit(audit)
  	@audit = audit
  	mail(:to => audit.auditees.map(&:email), :subject => "You have been invited to an audit")
  end

  def notify_auditees_that_checklist_is_prepared(audit)
    @audit = audit
    mail(:to => audit.auditees.map(&:email), :subject => "Checklist has been prepared for Audit")    
  end

  def notify_auditor_that_auditee_has_answered(audit)
    @audit = audit
    mail(:to => User.where(:id => audit.auditor).last.email, :subject => "All auditees has answered your Checklist")
  end

  def notify_auditee_about_recommendations(audit)
    @audit = audit
    mail(:to => audit.auditees.map(&:email), :subject => "Auditor has given a recommendation")  
  end

  def notify_auditor_about_responses(audit)
    @audit = audit
    mail(:to => User.where(:id => audit.auditor).last.email, :subject => "Auditee has submitted a response to your recommendation")
  end

  def notify_auditee_about_observations(audit)
    @audit = audit
    mail(:to => audit.auditees.map(&:email), :subject => "Auditor has submitted an observation for your response")
  end

  # Mailer for Artifact Priority
  def artifacts_reminder(answered_artifact, user)
    @answered_artifact = answered_artifact
    mail(:to => user.email, :subject => "Alert mail for submitting your artifacts")
  end

  # Mailer for NC Questions Priority
  def ncquestion_reminder(nc_question, user)
    @nc_question = nc_question
    mail(:to => user.email, :subject => "Alert mail for Answering")
    
  end

  # Mailer for Recommendation Priority
  def recommendation_reminder(recommendation, user)
    @recommendation = recommendation
    mail(:to => user.email, :subject => "Alert mail for giving response")
  end

  # Mailer for Escalation Matrix
  def escalation_matrix_mail(reminder_mail_to, reminder_mail_cc,escalation_details)
    @escalation_details = escalation_details
    mail(to: reminder_mail_to, cc: reminder_mail_cc , subject: "Alert Mail for giving response")
  end

end
