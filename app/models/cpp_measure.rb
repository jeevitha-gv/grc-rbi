class CppMeasure < ActiveRecord::Base

  # Associations
  belongs_to :company
  belongs_to :implementation_status
  belongs_to :compliance
  
  #Validations
  validates :name, presence: true
  validates :description, presence: true
  validates :compliance_id, presence: true
  validates :company_id, presence: true

  
end
