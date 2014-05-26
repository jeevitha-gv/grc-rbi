class User < ActiveRecord::Base


  # Include default devise modules. Others available are:
  #  :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable

  belongs_to :role
  has_many :privileges, through: :role

  has_many :teams, through: :user_teams
  has_many :user_teams

  belongs_to :company
  belongs_to :language

  has_one :attachment, as: :attachable
  has_one :profile

   validates :name, presence: true, uniqueness:{ message: MESSAGES["uniqueness"]["create"]["failure"]}#name should be unique
   validates :email, presence: true, uniqueness:{ message: MESSAGES["uniqueness"]["create"]["failure"]}#E-mailshould be unique

  # validates :user_name, :full_name , presence: true, uniqueness: true

  delegate :title, to: :dealer, prefix: true

  def is?( requested_role)
    self.role == requested_role.to_s if self.role.present?
  end

  def user_previleges
    @grouped_modular_action ||= self.role.privileges.map(&:modular).group_by(&:action_name) if self.role.present?
  end


# Restricting user to login if the account is disable
  # def active_for_authentication?
  #   super && !self.is_disabled
  # end

  protected

  def password_required?
    super if confirmed?
  end

  # Nested attribute for Profile
  accepts_nested_attributes_for :profile
  accepts_nested_attributes_for :attachment, reject_if: lambda { |a| a[:attachment_file].blank? }, allow_destroy: true
end
