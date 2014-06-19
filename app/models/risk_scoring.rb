class RiskScoring < ActiveRecord::Base
	
	# Associations
	has_many :control_measure
	belongs_to :scoring, :polymorphic => true
end
