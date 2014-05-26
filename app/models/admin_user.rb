class AdminUser < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable

  validates :email, presence: true, uniqueness:{ message: MESSAGES["uniqueness"]["create"]["failure"]}#E-mailshould be unique
end
