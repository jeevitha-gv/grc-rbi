class User < ActiveRecord::Base


  # Include default devise modules. Others available are:
  #  :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable

  belongs_to :role
  has_many :previleges, through: :role

  has_many :teams, through: :user_teams
  has_many :user_teams

  belongs_to :company
  belongs_to :language

  has_one :profile

  # validates :user_name, :full_name , presence: true, uniqueness: true

  delegate :title, to: :dealer, prefix: true

  def is?( requested_role)
    self.role == requested_role.to_s if self.role.present?
  end
  
  def user_previleges
    @grouped_modular_action ||= self.role.previleges.map(&:modular).group_by(&:action_name) if self.role.present?
  end
  
  protected

  def password_required?
    false
  end


  # Nested attribute for Profile
  accepts_nested_attributes_for :profile

end
