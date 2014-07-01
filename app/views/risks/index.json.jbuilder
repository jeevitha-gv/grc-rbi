json.data do |json|
  json.array!(@risks) do |risk|
      json.subject risk.subject
      json.status risk.risk_status_name
      if risk.risk_scoring_scoring_type == 'Custom'
        json.risk risk.risk_scoring_custom_value
      else
        json.risk risk.risk_scoring_calculated_risk
      end
      json.owner risk.risk_owner_user_name
      json.days_open 23
    end
end