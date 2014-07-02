class RiskScoring < ActiveRecord::Base

	# Associations
	has_many :control_measures
  belongs_to :risk
	belongs_to :scoring, :polymorphic => true

  SCORING_TYPES = [["Classic", "Classic"], ["OWASP", "OWASP"], ["DREAD", "DREAD"], ["CVSS", "CVSS"], ["Custom", "Custom"]]

end
