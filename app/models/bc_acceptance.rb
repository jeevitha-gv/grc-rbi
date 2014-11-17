class BcAcceptance < ActiveRecord::Base
	belongs_to :bc_analysis
	belongs_to :test_type
end
