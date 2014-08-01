class Vendor < ActiveRecord::Base

  # Assosciations
  belongs_to :company
  belongs_to :reseller_type
    
end
