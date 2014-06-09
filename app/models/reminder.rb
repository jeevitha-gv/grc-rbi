class Reminder < ActiveRecord::Base

	# Relationship
	belongs_to :priority
	belongs_to :company
	belongs_to :mail_to, class_name: 'ReminderAssignment', foreign_key: 'to'
	belongs_to :mail_cc, class_name: 'ReminderAssignment', foreign_key: 'cc'

	delegate :name, to: :priority, prefix: true, allow_nil: true
	delegate :name, to: :mail_to, prefix: true, allow_nil: true
	delegate :name, to: :mail_cc, prefix: true, allow_nil: true

	# validation
	validates :priority_id ,:uniqueness => {:scope => :company_id}
	validates :value, :numericality => { :greater_than_or_equal_to => 1, :less_than_or_equal_to => 30, :only_integer => true}
	validates :mail_count, :numericality => { :greater_than_or_equal_to => 1, :less_than_or_equal_to => 30 , :only_integer => true}

	 
	# Method to check priority and send mail according to the priority
	def self.check_priority(company_id, priority_id)
	    reminder = Reminder.where("company_id = ? AND priority_id = ?", company_id, priority_id).last
	    if reminder
		    reminder_value = (reminder.timeline == 1 ? reminder.value : reminder.value * 24)
		    if((reminder_value.to_i.hours + reminder.last_sent) <= Time.now)
		      return reminder
		    end
	    end
	    return false
	end

	# Methods to get emails for escalation

	def self.get_escalation_mails(company,user,audit)
		return reminder_mail(self.mail_to_name, company, user, audit),reminder_mail(self.mail_cc_name, company, user, audit)
	end

	def reminder_mail(mail,company,user,audit)
		case mail
			when "Auditor"
				return audit.auditory.email
			when "Auditee"
				return user.email
			when "Company Admin"
				return company.company_admin.email
			when "Reporting Manager"
				return user.user_manager.email
			when "Manager of Manager"
				return user.user_manager.user_manager.email
			else
				return company.company_admin.email
		end
	end

end
