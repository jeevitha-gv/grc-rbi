class Reminder < ActiveRecord::Base

	# Relationship
	belongs_to :priority
	belongs_to :company
	belongs_to :reminder_assignment

	delegate :name, to: :priority, prefix: true
	delegate :name, to: :reminder_assignment, prefix: true

	# validation
	validates :priority_id ,:uniqueness => {:scope => :company_id}
	validates :value, :numericality => { :greater_than_or_equal_to => 1, :less_than_or_equal_to => 30, :only_integer => true}
	validates :mail_count, :numericality => { :greater_than_or_equal_to => 1, :less_than_or_equal_to => 30 , :only_integer => true}


	def self.check_priority(company_id, priority_id)
	    reminder = Reminder.where("company_id = ? AND priority_id = ?", company_id, priority_id).last
	    if reminder
		    reminder_value = (reminder.timeline == 1 ? reminder.value : reminder.value * 24)
		    if((reminder_value.to_i.hours + reminder.last_sent) <= Time.now)
		      return true
		    end
	    end
	    return false
	end
end
