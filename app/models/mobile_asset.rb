class MobileAsset < ActiveRecord::Base

  # Assosciations
  belongs_to :company
  belongs_to :device_type
  belongs_to :location
  belongs_to :department
  
end
