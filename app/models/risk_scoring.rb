class RiskScoring < ActiveRecord::Base

	# Associations
	has_many :control_measures
  belongs_to :risk
	belongs_to :scoring, :polymorphic => true

  accepts_nested_attributes_for :scoring

  after_create :update_scoring
  after_update :update_scoring

  SCORING_TYPES = [["Classic", "ClassicScoring"], ["OWASP", "OwaspScoring"], ["DREAD", "DreadScoring"], ["CVSS", "CvssScoring"], ["Custom", "Custom"]]

  	delegate :risk_model , to: :risk , prefix: true, allow_nil: true

  def update_scoring
  	if((self.scoring_type_changed? || self.scoring_id_changed?) && self.scoring_type != "Custom")
  		case self.scoring_type
  			when "DreadScoring"
  				self.dread_scoring_method
  			when "OwaspScoring"
  				self.owasp_scoring_method
  			else
  			 	self.classic_scoring_method(self.risk_risk_model.name)
  		end
  	end
  end

  # DREAD Risk Scoring
	def dread_scoring_method
		scoring = self.scoring
		risk_score = (scoring.dread_damage_potential + scoring.dread_reproducibility + scoring.dread_exploitability + scoring.dread_affected_users + scoring.dread_discoverability).to_f / 5
		# self.calculated_risk = risk_score
		self.update_columns(:calculated_risk => risk_score)
	end

	# OWASP Risk Scoring
	def owasp_scoring_method
		scoring = self.scoring
		threat_agent_factor = (scoring.owasp_skill_level + scoring.owasp_motive + scoring.owasp_opportunity + scoring.owasp_size) / 4
		vunlnerability_factor = (scoring.owasp_awareness + scoring.owasp_intrusion_detection + scoring.owasp_ease_of_discovery + scoring.owasp_ease_of_exploit) / 4
		technical_impact = (scoring.owasp_loss_of_confidentiality + scoring.owasp_loss_of_integrity +  scoring.owasp_loss_of_availability + scoring.owasp_loss_of_accountability) / 4
		business_impact = (scoring.owasp_financial_damage + scoring.owasp_reputation_damage + scoring.owasp_non_compliance + scoring.owasp_privacy_violation) / 4

		risk_likelihood = ((threat_agent_factor + vunlnerability_factor) / 2).to_f
		risk_impact = ((technical_impact + business_impact) / 2).to_f
		risk_score = (risk_likelihood * risk_impact) / 10

		self.update_columns(:calculated_risk => risk_score)
	end


	# CLASSIC Risk Scoring
	def classic_scoring_method(risk_model)
		scoring = self.scoring

		case risk_model
			when "Likelihood * Impact + 2(Impact)"
				risk_score = ((scoring.likelihood * scoring.impact) + (2 * scoring.impact)).to_f * (10.0/35.0)
			when "Likelihood * Impact + Impact"
				risk_score = ((scoring.likelihood * scoring.impact) + scoring.impact).to_f * (10.0/30.0)
			when "Likelihood * Impact + Likelihood"
				risk_score = ((scoring.likelihood * scoring.impact) + scoring.likelihood) * (10.0/30.0)
			when "Likelihood * Impact + 2(Likelihood)"
				risk_score = ((scoring.likelihood * scoring.impact) + (2 * scoring.likelihood) )  * (10.0/35.0)
			when "Likelihood * Impact"
				risk_score = (scoring.likelihood * scoring.impact) * (10.0/25.0)
			else
				risk_score = 10
		end

		self.update_columns(:calculated_risk => risk_score.round(1))
	end

end
