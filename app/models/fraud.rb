class Fraud < ActiveRecord::Base
	belongs_to :company
	belongs_to :location
	belongs_to :fraud_type
	belongs_to :technology
	belongs_to :team
	belongs_to :fraud_status
	belongs_to :investigation_object
	belongs_to :risk_value


    belongs_to :investigator, class_name: 'User', foreign_key: 'investigator'
    belongs_to :fraud_manager, class_name: 'User', foreign_key: 'fraud_manager'


	has_one :investigation
	has_one :fraud_review
	has_one :fraud_status
end
