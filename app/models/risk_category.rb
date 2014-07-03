class RiskCategory < ActiveRecord::Base

<<<<<<< HEAD
  #Assosciations
  belongs_to :company

=======
  has_many :risks
  belongs_to :company
>>>>>>> 40322c09dcebf3daf1b7ccee7d494b3a061166f2
end
