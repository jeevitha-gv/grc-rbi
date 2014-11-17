class Recurrence < ActiveRecord::Base
	has_many :BcPlans
	has_many :BcMaintenances
end
