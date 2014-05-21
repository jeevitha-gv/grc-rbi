class User < ActiveRecord::Base


  # Include default devise modules. Others available are:
  #  :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable

  has_many :roles, :through => :previleges
  has_many :previleges

  has_many :teams, :through => :user_teams
  has_many :user_teams

  belongs_to :company
  belongs_to :language

  has_one :profile

  #validates :user_name, :full_name, presence: true, uniqueness: true
  protected

  def password_required?
    false
  end
  
end
