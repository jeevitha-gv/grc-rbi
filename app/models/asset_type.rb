class AssetType < ActiveRecord::Base


# Assosciations with Asset Module
  has_many :other_assets

end
