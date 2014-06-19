class RiskScoring < ActiveRecord::Base

	# Associations
	has_many :control_measures
  belongs_to :risk
	belongs_to :scoring, :polymorphic => true
end
