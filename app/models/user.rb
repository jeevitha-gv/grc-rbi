class User < ActiveRecord::Base


  # Include default devise modules. Others available are:
  #  :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :confirmable, :lockable, :authentication_keys => [:login]

  belongs_to :role
  has_many :privileges, through: :role

  has_many :teams, through: :user_teams
  has_many :user_teams

  belongs_to :company
  belongs_to :language

  has_one :attachment, as: :attachable
  has_one :profile
  has_many :nc_questions

  has_many :checklist_recommendations

  has_many :audit_auditees

  has_many :auditee_audit, through: :audit_auditees, source: :audit

  has_many :auditor_audits, class_name: 'Audit', foreign_key: 'auditor'

  has_many :artifact_answers

  belongs_to :user_manager, class_name: 'User', foreign_key: 'manager'


# attribute to login with username or email
  attr_accessor :login

   validates_format_of :full_name, :with =>/\A[a-zA-Z ]+\z/, :if => Proc.new{|f| !f.full_name.blank? }
   validates :full_name, length: { maximum: 50 }, :if => Proc.new{|f| !f.full_name.blank? }
   validates :user_name, presence: true, :if => Proc.new{|f| f.user_name.blank? }
   validates :user_name, uniqueness: true, :if => Proc.new{|f| !f.user_name.blank? }
   validates_format_of :user_name, :with =>/\A(?=.*[a-z])[a-z\d]+\Z/i, :if => Proc.new{|f| !f.user_name.blank? }
   validates :user_name, length: { maximum: 52 }, :if => Proc.new{|f| !f.user_name.blank? }
   validates :email, presence: true
   validates :email, uniqueness: true, :if => Proc.new{|f| !f.email.blank? }
   validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create, :if => Proc.new{|f| !f.email.blank? }
   validates :role_id, presence: true
   validates :password, :confirmation => true

  # validates :user_name, :full_name , presence: true, uniqueness: true

  delegate :title, to: :dealer, prefix: true
  delegate :title, to: :role, prefix: true, allow_nil: true

  def is?( requested_role)
    self.role.title == requested_role.to_s if self.role.present?
  end

  def user_previleges
    @grouped_modular_action ||= self.role.privileges.map(&:modular).group_by(&:action_name) if self.role.present?
  end


# Restricting user to login if the account is disable
  def active_for_authentication?
    super && !self.is_disabled
  end

  def accessible_audits
    if(self.role.title == "company_admin")
      Audit.where(company_id: self.company_id)
    else
      (self.auditor_audits + self.auditee_audit).uniq
    end
  end

  protected

  def password_required?
    super if confirmed?
  end

  # Nested attribute for Profile
  accepts_nested_attributes_for :profile
  accepts_nested_attributes_for :attachment, reject_if: lambda { |a| a[:attachment_file].blank? }, allow_destroy: true


  # to have a login with username or email , we have to overwrite the method find_first_by_auth_conditions in devise

    def self.find_first_by_auth_conditions(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions).where(["lower(user_name) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      else
        where(conditions).first
      end
    end
end
