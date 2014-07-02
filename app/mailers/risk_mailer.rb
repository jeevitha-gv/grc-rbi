class RiskMailer < ActionMailer::Base
  default from: "noreply@fixrnix.in"

  def notify_users_about_risk(risk, email, subject)
    @risk = risk
    mail(:to => email, content_type: "text/html", :subject => "#{subject}" )
  end
end