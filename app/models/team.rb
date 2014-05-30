class Team < ActiveRecord::Base

  #associations
  has_many :users, :through => :user_teams
  has_many :user_teams
  has_many :audits
  belongs_to :company

  # validations
  validates :name, presence:true
  validates_format_of :name, :with =>/\A(?=.*[a-z])[a-z\d\s]+\Z/i, :if => Proc.new{ |f| !f.name.blank? }
  validates :name, :uniqueness => {:scope => :company_id}, :if => Proc.new{ |f| !f.name.blank? }

end
