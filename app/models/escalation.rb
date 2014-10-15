class Escalation < ActiveRecord::Base

	has_many :evaluates
	belongs_to :incident_user, class_name: 'User', foreign_key: 'user'
	belongs_to :incident_priority

	validates_numericality_of :value, :if => Proc.new{|f| !f.value.blank? }
	validates :user, presence:true
	validates_numericality_of :level, :if => Proc.new{|f| !f.level.blank? }
	validates :incident_priority_id, presence:true
	validates :time_line, presence:true
	validates_numericality_of :mail_count, :if => Proc.new{|f| !f.mail_count.blank? }
	validates :to, presence:true
	validates :cc, presence:true
	validates :bcc, presence:true

end
