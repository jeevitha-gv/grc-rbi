class Computer < ActiveRecord::Base

  # Assosciations
  belongs_to :company
  belongs_to :computer_category
  belongs_to :asset_status
  belongs_to :location
  belongs_to :department
  belongs_to :computertechnical_contact, class_name: 'User', foreign_key: 'technical_contact'
  belongs_to :computerasset_owner, class_name: 'User', foreign_key: 'asset_owner'
  
end
