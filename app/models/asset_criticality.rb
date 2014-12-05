class AssetCriticality < ActiveRecord::Base
	has_many :asset_confi, class_name: 'Asset', foreign_key: 'confidentiality'
  has_many :asset_avail, class_name: 'Asset', foreign_key: 'availability'
  has_many :asset_integ, class_name: 'Asset', foreign_key: 'integrity'
end
