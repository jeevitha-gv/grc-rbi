class DeviceType < ActiveRecord::Base

  # Assosciations with Asset Module
has_many :mobile_assets

end
