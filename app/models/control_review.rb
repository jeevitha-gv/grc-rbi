class ControlReview < ActiveRecord::Base

	belongs_to :control
	belongs_to :control_approval
	belongs_to :fraud_related
	
	delegate :name, :to => :control_approval, prefix: true, allow_nil: true
	delegate :name, :to => :fraud_related, prefix: true, allow_nil: true

end
