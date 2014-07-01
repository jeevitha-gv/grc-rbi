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
end
