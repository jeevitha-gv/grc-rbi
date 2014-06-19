class CppMeasure < ActiveRecord::Base

  # Associations
  belongs_to :company
  belongs_to :implementation_status
  belongs_to :compliance
end
