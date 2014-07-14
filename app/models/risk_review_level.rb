class RiskReviewLevel < ActiveRecord::Base

  # Associations
  belongs_to :company

  scope :review_level, lambda {|name, company_id| where(name: name, company_id: company_id)}

  validate :risk_review_level_value

  def risk_review_level_value
    risk_review_levels = self.company.risk_review_levels
    medium_risk = risk_review_levels.where(:name=>'MEDIUM').last
    high_risk = risk_review_levels.where(:name=>'HIGH').last
    low_risk = risk_review_levels.where(:name=>'LOW').last

    if self.name == 'LOW'
      if self.value >= medium_risk.value || self.value >= 10
        self.errors[:value] = "Low risk review level value should be lower than medium risk review level"
      end
    elsif self.name == 'MEDIUM'
      if self.value >= high_risk.value || self.value <= low_risk.value || self.value >= 10
        self.errors[:value] = "Medium risk review level value should be lower than high risk review level and greater than low risk review level"
      end
    elsif self.name == 'HIGH'
      if self.value <= medium_risk.value || self.value >= 10
        self.errors[:value] = "High risk review level value should be greater than medium risk review level or value should be less than 10"
      end
    end

  end
end
