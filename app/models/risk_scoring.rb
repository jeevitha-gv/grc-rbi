class RiskScoring < ActiveRecord::Base

	# Associations
	has_many :control_measures
    belongs_to :risk
	belongs_to :scoring, :polymorphic => true
    
    after_create :update_scoring
    after_update :update_scoring

  	SCORING_TYPES = [["Classic", "Classic"], ["OWASP", "OWASP"], ["DREAD", "DREAD"], ["CVSS", "CVSS"], ["Custom", "Custom"]]

  def update_scoring
  	if((self.scoring_type_has_changed || self.scoring_id_has_changed?) && self.scoring_type != "Custom")
  		case self.scoring_type
  			when  "dread_scorings"
  				self.dread_scoring
  			when "owasp_scorings"
  				self.owasp_scorings
  			else
  			 	self.classic_scoring
  		end
  	end
  end

  # DREAD Risk Scoring 
	def dread_scoring
		scoring = self.scoring
		risk_scoring = (scoring.dread_damage_potential + dread_reproducibility + dread_exploitability + dread_affected_users + dread_discoverability) / 5
		self.calculated_risk = risk_scoring
		self.save
	end

	# OWASP Risk Scoring 
	def owasp_scoring
		scoring = self.scoring
		threat_agent_factor = ( owasp_skill_level + owasp_motive + owasp_opportunity + owasp_size) / 4
		vunlnerability_factor = ( owasp_awareness + owasp_intrusion_detection + owasp_ease_of_discovery + owasp_ease_of_exploit ) / 4
		technical_impact = ( owasp_loss_of_confidentiality + owasp_loss_of_integrity +  owasp_loss_of_availability + owasp_loss_of_accountability ) / 4
		business_impact = ( owasp_financial_damage + owasp_reputation_damage + owasp_non_compliance + owasp_privacy_violation ) / 4
		
		risk_likelihood = (threat_agent_factor + vunlnerability_factor) / 2
		risk_impact = (technical_impact + business_impact) / 2

		risk_scoring = (risk_likelihood * risk_impact ) / 100

		self.calculated_risk = risk_scoring
		self.save
	end


	# CLASSIC Risk Scoring
	def classic_scoring(risk_modal_name)

		 # risk_scoring_modal_1 = ((likelihood * impact) + 2(impact))  * (10/35)
		 # risk_scoring_modal_2 = ((likelihood * impact) + impact) * (10/30)
		 # risk_scoring_modal_3 = ((likelihood * impact) + likelihood) * (10/30)
		 # risk_scoring_modal_4 = ((likelihood * impact) + 2(likelihood))  * (10/35)
		 # risk_scoring_modal_5 = (likelihood * impact) * (10/25)

		case risk_modal_name
			when "Likelihood * Impact + 2(Impact)"  
				return ((likelihood * impact) + 2(impact))  * (10/35)
			when "Likelihood * Impact + Impact"
				return ((likelihood * impact) + impact) * (10/30) 
			when "Likelihood * Impact + Likelihood"
				return ((likelihood * impact) + likelihood) * (10/30)
			when "Likelihood * Impact + 2(Likelihood)"
				return ((likelihood * impact) + 2(likelihood))  * (10/35)
			else
				return (likelihood * impact) * (10/25)
		end
	end

end