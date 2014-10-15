class IncidentMailer < ActionMailer::Base
  default from: "noreply@fixrnix.in"

  def notify_users_about_incident(incident, email, subject, name)
    @incident = incident
    @name = name
    mail(:to => email, content_type: "text/html", :subject => "#{subject}" )
  end

  def incident_review_notify(incident)
    @incident = incident
    #@days = review_days
    mail(:to => evaluate.evaluate_assignee.email, content_type: "text/html", :subject => "Your next review date for #{risk.subject} is approaching."  )
  end

  def send_notification(company)
    @company = company
    email = "shan@fixrnix.in"
    mail(:to => email, content_type: "text/html", :subject => "FixNix GRC got a new subscription")
  end
end
