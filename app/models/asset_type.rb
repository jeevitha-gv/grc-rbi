class AssetType < ActiveRecord::Base


  # Assosciations with Asset Module
  has_many :other_assets
  belongs_to :company

  # Validations
  validates_presence_of :name
  validates_uniqueness_of :name, scope: [:company_id], :case_sensitive => false

  
  scope :asset_type_name, ->(id) { where(id: id).first.name}
  scope :for_type_by_company,lambda {|asset_type_name, company_id| where("lower(name)=? and company_id=?", asset_type_name, company_id)}
end
