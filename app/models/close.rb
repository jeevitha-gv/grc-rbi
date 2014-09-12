class Close < ActiveRecord::Base

	belongs_to :incident
	belongs_to :close_evaluation
	belongs_to :close_status
end
