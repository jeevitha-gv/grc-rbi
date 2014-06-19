class Risk < ActiveRecord::Base

  #Assosciations
  belongs_to :risk_status
  belongs_to :compliance
  belongs_to :location
  belongs_to :category #Need Clarity
  belongs_to :team

end
