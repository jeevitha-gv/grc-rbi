namespace :reminder do
  desc "Reminders"
  task notify: :environment do
  	company = Company.active
    company.each do |company|
      audit = company.active_audits_with_skipped
      audit.each do |audit|
        
        # Artificats Remainders
        logger.info "Aritifacts Remainder"
         audit.unanswered_artifacts.each do |answered_artifacts|
            if(Reminder.check_priority(company.id, answered_artifacts.priority_id))
              UniversalMailer.artifacts_reminder(answered_artifacts).deliver
            end
         end

        #Checlist Recommendation Reminders
        logger.info "Checklist Recommendation Reminder"
        audit.unresponsive_recommendation.each do |recommendation|
          if(Reminder.check_priority(company.id,recommendation.priority_id))
            UniversalMailer.recommendation_reminder(recommendation).deliver
          end
        end

        # Non Compliance Questions 
        logger.info "Non Compliance Reminder"
        audit.unanswered_nc_questions.each do |nc_question|
          if (Reminder.check_priority(company.id,nc_question.priority_id))
            UniversalMailer.ncquestion_reminder(nc_question).deliver
          end
        end

      end
    end
  end
end