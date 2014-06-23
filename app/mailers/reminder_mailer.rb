class ReminderMailer < ActionMailer::Base

  default from: "noreply@fixrnix.in"

  def notify_auditor_about_audit(audit)
  	@audit = audit
  	mail(:to => audit.auditory_email, :subject => "Your Audit has been successfully created")
  end

  def notify_auditees_about_audit(audit)
  	@audit = audit
  	mail(:to => audit.auditees.map(&:email), :subject => "You have been invited to an audit")
  end

  def notify_auditees_that_checklist_is_prepared(nc_question)
    @nc_question = nc_question
    mail(:to => nc_question.auditee_email, :subject => "Checklist has been prepared for NonCompliance Audit")
  end

  def notify_auditee_about_checklist(artifact_answer)
    @artifact_answer = artifact_answer
    mail(:to => artifact_answer.responsibility_email, :subject => "Checklist has been prepared for Compliance Audit")
  end

  def notify_auditor_that_auditee_has_answered(audit)
    @audit = audit
    mail(:to => audit.auditory_email, :subject => "All auditees has answered your Checklist")
  end

  def notify_auditee_about_recommendations(checklist_recommendation)
    @checklist_recommendation = checklist_recommendation
    mail(:to => checklist_recommendation.checklist.artifact_answers.last.responsibility_email, :subject => "Auditor has given a recommendation")

  end

  def notify_auditee_about_nc_recommendations(checklist_recommendation)
    @checklist_recommendation = checklist_recommendation
    mail(:to => checklist_recommendation.checklist.nc_question.auditee_email, :subject => "Auditor has given a recommendation")
  end

  def notify_auditor_about_responses(checklist_recommendation)
    @checklist_recommendation = checklist_recommendation
    mail(:to => checklist_recommendation.checklist.audit.auditory_email, :subject => "Auditee has submitted a response to your recommendation")
  end

  def notify_auditee_about_observations(checklist_recommendation)
    @checklist_recommendation = checklist_recommendation
    mail(:to => checklist_recommendation.auditee_email, :subject => "Auditor has submitted an observation for your response")
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
  def escalation_mail_arifact_answer(reminder_mail_to, reminder_mail_cc,answered_artifacts)
    @answered_artifact = answered_artifacts
    mail(to: reminder_mail_to, cc: reminder_mail_cc , subject: "Escalation for giving response")
  end

  def escalation_mail_recommendation(reminder_mail_to, reminder_mail_cc,recommendation)
    @recommendation = recommendation
    mail(to: reminder_mail_to, cc: reminder_mail_cc , subject: "Escalation for giving response")
  end

  def escalation_mail_nc_questions(reminder_mail_to, reminder_mail_cc,nc_question)
    @nc_question = nc_question
    mail(to: reminder_mail_to, cc: reminder_mail_cc , subject: "Escalation for giving response")
  end

end
