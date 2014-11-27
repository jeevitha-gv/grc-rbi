class BcImplementation < ActiveRecord::Base
	belongs_to :implementation_status
	belongs_to :bc_analysis
end
