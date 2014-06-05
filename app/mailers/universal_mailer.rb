class UniversalMailer < ActionMailer::Base

  default from: "noreply@fixrnix.in"

  def notify_auditor_about_audit(audit)
  	@audit = audit
  	mail(:to => User.where(:id => audit.auditor).last.email, :subject => "Your Audit has been successfully created")
  end

  def notify_auditees_about_audit(audit)
  	@audit = audit  	
  	mail(:to => User.where(:id => audit.auditor).last.email, :subject => "You have been invited to an audit")
  end

end
