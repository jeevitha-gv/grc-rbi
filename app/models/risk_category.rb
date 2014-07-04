class RiskCategory < ActiveRecord::Base

  has_many :risks
  belongs_to :company

  # Scopes
  scope :for_company, lambda {|id| where(:company_id => [id, nil] ) }

end
