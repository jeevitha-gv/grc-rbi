class RiskScoring < ActiveRecord::Base

	# Associations
	has_many :control_measures
  belongs_to :risk
	belongs_to :scoring, :polymorphic => true

  SCORING_TYPES = [["Classic", "ClassicScoring"], ["OWASP", "OwaspScoring"], ["DREAD", "DreadScoring"], ["CVSS", "CvssScoring"], ["Custom", "Custom"]]

end
