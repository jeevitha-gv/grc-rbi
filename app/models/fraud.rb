class Fraud < ActiveRecord::Base
	belongs_to :company
	belongs_to :location
	belongs_to :fraud_type
	belongs_to :technology
	belongs_to :team
	belongs_to :fraud_status
	belongs_to :investigation_object
	belongs_to :risk_value


  
    belongs_to :fraud_inves, class_name: 'User', foreign_key: 'investigator'
	belongs_to :fraud_man, class_name: 'User', foreign_key: 'fraud_manager'
	belongs_to :fraud_resp, class_name: 'User', foreign_key: 'person_responsible'


    # delegate :user_name, to: :fraud_investigator, prefix: true, allow_nil: true
    # delegate :user_name, to: :fraud_manager, prefix: true, allow_nil: true
    # delegate :user_name, to: :person_responsible, prefix: true, allow_nil: true

	has_one :investigation
	has_one :fraud_review
end
