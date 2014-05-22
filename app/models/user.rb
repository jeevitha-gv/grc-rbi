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

  has_one :attachment, as: :attachable
  has_one :profile

  # validates :user_name, :full_name , presence: true, uniqueness: true

  delegate :title, to: :dealer, prefix: true

  protected

  def password_required?
    false
  end


  # Nested attribute for Profile
  accepts_nested_attributes_for :profile
  accepts_nested_attributes_for :attachment, reject_if: lambda { |a| a[:attachment_file].blank? }, allow_destroy: true
end
