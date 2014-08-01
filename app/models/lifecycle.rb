class Lifecycle < ActiveRecord::Base

  # Assosciations
  belongs_to :other_asset
  belongs_to :lifecycle_type_id
  belongs_to :user

end
