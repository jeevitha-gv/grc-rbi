namespace :reminder do
  desc "Reminders"
  task incident_notification: :environment do
     company = Company.active
     company.each do |company|
     incident=Incident.all
     incident.each do |incident|
     user = company.users

      if (incident.evaluate.target_date - 2.days)
        IncidentMailer.delay.incident_review_notify(incident)
      end
     if (incident.evaluate.target_date == Date.today && user.role_title == "Incidentmanager")
        IncidentMailer.delay.incident_review_notify(incident) if (incident_status_name == "In-Progess")
      end

end
end
end
end