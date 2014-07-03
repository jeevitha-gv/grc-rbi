module RisksHelper

	def days_open(score, risk)
		if score > @high_risk.value
			@high_risk.days - (Date.today - Date.parse(risk.created_at.strftime('%Y-%m-%d'))).to_i
		elsif (score > @medium_risk.value && score < @high_risk.value)
			@medium_risk.days - (Date.today - Date.parse(risk.created_at.strftime('%Y-%m-%d'))).to_i
		elsif (score > @low_risk_rate.value && score < @medium_risk.value)
			@low_risk.days - (Date.today - Date.parse(risk.created_at.strftime('%Y-%m-%d'))).to_i
		end
	end

  def risk_scoring_type_classic(risk)
    return true if (risk.risk_scoring.present? && risk.risk_scoring.scoring_type == 'ClassicScoring')
  end

  def risk_scoring_type_owasp(risk)
    return true if (risk.risk_scoring.present? && risk.risk_scoring.scoring_type == 'OwaspScoring')
  end

  def risk_scoring_type_dread(risk)
    return true if (risk.risk_scoring.present? && risk.risk_scoring.scoring_type == 'DreadScoring')
  end

  def risk_scoring_type_cvss(risk)
    return true if (risk.risk_scoring.present? && risk.risk_scoring.scoring_type == 'CvssScoring')
  end

  def risk_scoring_type_custom(risk)
    return true if (risk.risk_scoring.present? && risk.risk_scoring.scoring_type == 'Custom')
  end
end
