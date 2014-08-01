class Lifecycle < ActiveRecord::Base

  # Assosciations
  belongs_to :other_asset
  belongs_to :lifecycle_type
  belongs_to :user

end
