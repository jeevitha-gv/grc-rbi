class FraudReview < ActiveRecord::Base
    belongs_to :fraud
    
	belongs_to :assign_tothe, class_name: 'User', foreign_key: 'assign_to'
end
