class SkippedAuditReminder < ActiveRecord::Base

	# Relationship
	belongs_to :audit
	belongs_to :skipped_by, :class_name => "User"

	def self.audits
		SkippedAuditReminder.all.map(&:audit)
	end
end
