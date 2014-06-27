class RiskCategory < ActiveRecord::Base

  #Assosciations
  # Need Clarification for risks
  # has_many :risks, class_name: 'Risk', foriegn_key: 'category_id'
end
