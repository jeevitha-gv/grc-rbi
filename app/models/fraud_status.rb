class FraudStatus < ActiveRecord::Base
	has_many :frauds
end
