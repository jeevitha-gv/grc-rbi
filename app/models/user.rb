class User < ActiveRecord::Base


  # Include default devise modules. Others available are:
  #  :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable

  belongs_to :roles
  has_many :previleges, through: :roles

  has_many :teams, through: :user_teams
  has_many :user_teams

  belongs_to :company
  belongs_to :language

  has_one :profile

<<<<<<< HEAD
  validates :user_name, :full_name , presence: true, uniqueness: true
  
  delegate :title, to: :dealer, prefix: true
=======
  #validates :user_name, :full_name, presence: true, uniqueness: true
  protected

  def password_required?
    false
  end
  
>>>>>>> 89a968c4c095e36eaa402c65b32596147d2b42f2
end
