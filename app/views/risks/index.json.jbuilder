json.data do |json|
  json.array!(@risks) do |risk|
      json.subject risk.subject
      json.status risk.risk_status_name
      if risk.risk_scoring_scoring_type == 'Custom'
        json.risk risk.risk_scoring_custom_value
				json.days_open days_open(risk.risk_scoring_custom_value, risk)
      else
        json.risk risk.risk_scoring_calculated_risk
				json.days_open days_open(risk.risk_scoring_calculated_risk, risk)
      end
      json.owner risk.risk_owner_user_name
    end
end