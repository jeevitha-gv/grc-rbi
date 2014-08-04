class AssetType < ActiveRecord::Base


# Assosciations with Asset Module
  has_many :other_assets
  belongs_to :company

# Validations
  validates_presence_of :name
  validates_uniqueness_of :name

end
