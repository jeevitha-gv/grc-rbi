class Priority < ActiveRecord::Base

# Relationship
  has_many :nc_questions
  has_many :checklist_recommendations
  has_many :artifact_answers
  has_many :reminders
  has_many :impact, class_name: 'Document', foreign_key: 'impact_id'
  has_many :impact, class_name: 'Computer', foreign_key: 'impact_id'
  has_many :asset_confi, class_name: 'InformationAsset', foreign_key: 'confidentiality'
  has_many :asset_avail, class_name: 'InformationAsset', foreign_key: 'availability'
  has_many :asset_integ, class_name: 'InformationAsset', foreign_key: 'integrity'


  # Validation
  validates :name, presence: true, :if => Proc.new{ |f| f.name.blank? }
  validates_format_of :name, :with =>/\A(?=.*[a-z])[a-z\d\s]+\Z/i, :if => Proc.new{ |f| !f.name.blank? }
  validates :name, uniqueness: true, :if => Proc.new{ |f| !f.name.blank? }
end