class BcMaintenance < ActiveRecord::Base
	belongs_to :bc_analysis
	belongs_to :recurrence
end
