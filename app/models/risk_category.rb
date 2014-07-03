class RiskCategory < ActiveRecord::Base

  has_many :risks
  belongs_to :company
end
