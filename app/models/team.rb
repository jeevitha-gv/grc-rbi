class Team < ActiveRecord::Base

  #associations
  has_many :users, :through => :user_teams
  has_many :user_teams, :dependent => :destroy
  has_many :audits
  belongs_to :company
  belongs_to :department
  has_many :risks

  # validations
  validates :name, presence:true
  validates_format_of :name, :with =>/\A(?=.*[a-z])[a-z\d\s -]+\Z/i, :if => Proc.new{ |f| !f.name.blank? }
  validates :name, :uniqueness => {:scope => :company_id}, :if => Proc.new{ |f| !f.name.blank? }

  #scope
  scope :for_department_and_company, lambda {|department_id, company_id| where(department_id: department_id, company_id: company_id)}
  scope :for_id, lambda {|team_id| where(id: team_id)}
  scope :for_name_by_department, lambda { |team_name, department_id| where("lower(name) = ? and department_id = ?", team_name, department_id) }

end
