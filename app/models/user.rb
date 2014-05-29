class User < ActiveRecord::Base


  # Include default devise modules. Others available are:
  #  :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :confirmable, :lockable

  belongs_to :role
  has_many :privileges, through: :role

  has_many :teams, through: :user_teams
  has_many :user_teams

  belongs_to :company
  belongs_to :language

  has_one :attachment, as: :attachable
  has_one :profile

   #validates_format_of :full_name, :with =>/\A[a-zA-Z1-9]+\z/
   #validates :full_name, length: { maximum: 50 }
   validates :user_name, presence: true
   validates :user_name, uniqueness: true
   validates_format_of :user_name, :with =>/\A(?=.*[a-z])[a-z\d]+\Z/i
   validates :user_name, length: { maximum: 52 }
   validates :email, presence: true
   validates :email, uniqueness:{ message: MESSAGES["users"]["email"]["uniqueness"]["failure"]}
   validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create, presence:{message: MESSAGES["users"]["email"]["valid"]["failure"]}
   validates :role_id, presence:{message: MESSAGES["users"]["role"]["name"]["failure"]}
  # validates :user_name, :full_name , presence: true, uniqueness: true

  delegate :title, to: :dealer, prefix: true

  def is?( requested_role)
    self.role == requested_role.to_s if self.role.present?
  end

  def user_previleges
    @grouped_modular_action ||= self.role.privileges.map(&:modular).group_by(&:action_name) if self.role.present?
  end


# Restricting user to login if the account is disable
  def active_for_authentication?
    super && !self.is_disabled
  end

  protected

  def password_required?
    super if confirmed?
  end

  # Nested attribute for Profile
  accepts_nested_attributes_for :profile
  accepts_nested_attributes_for :attachment, reject_if: lambda { |a| a[:attachment_file].blank? }, allow_destroy: true
end
