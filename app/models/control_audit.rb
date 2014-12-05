class ControlAudit < ActiveRecord::Base

	belongs_to :control
	belongs_to :control_approval
	belongs_to :control_review
	
	delegate :name, :to => :control_approval, prefix: true, allow_nil: true
	delegate :name, :to => :control_review, prefix: true, allow_nil: true
	
end
