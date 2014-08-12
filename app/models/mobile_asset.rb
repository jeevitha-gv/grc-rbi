class MobileAsset < ActiveRecord::Base

  # Assosciations
  belongs_to :company
  belongs_to :device_type
  belongs_to :location
  belongs_to :department
  
  # Validations
  validates_presence_of :model
  validates_presence_of :manufacturer
  validates_presence_of :serial_number

end
