class Priority < ActiveRecord::Base

# Relationship
  has_many :nc_questions
  has_many :checklist_recommendations
  has_many :artifact_answers
  has_many :reminders
  has_many :asset_confi, class_name: 'Asset', foreign_key: 'confidentiality'
  has_many :asset_avail, class_name: 'Asset', foreign_key: 'availability'
  has_many :asset_integ, class_name: 'Asset', foreign_key: 'integrity'
  has_many :bc_confi, class_name: 'BcAnalysis', foreign_key: 'confidentiality'
  has_many :bc_avail, class_name: 'BcAnalysis', foreign_key: 'availability'
  has_many :bc_integ, class_name: 'BcAnalysis', foreign_key: 'integrity'



  # Validation
  validates :name, presence: true, :if => Proc.new{ |f| f.name.blank? }
  validates_format_of :name, :with =>/\A(?=.*[a-z])[a-z\d\s]+\Z/i, :if => Proc.new{ |f| !f.name.blank? }
  validates :name, uniqueness: true, :if => Proc.new{ |f| !f.name.blank? }
end