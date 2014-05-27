class Location < ActiveRecord::Base
 #publicactivity gem
	 include PublicActivity::Model
   tracked owner: ->(controller, model) { controller && controller.current_user }
   tracked ip: ->(controller,model) {controller && controller.current_user.current_sign_in_ip}
  validates :name, uniqueness: {scope: :company_id}, presence: true, format: { with: /\A[a-zA-Z]+\z/ }, uniqueness:{ message: MESSAGES["uniqueness"]["create"]["failure"]}

  has_many :departments
  belongs_to :company

end
