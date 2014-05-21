class Location < ActiveRecord::Base
 #publicactivity gem
	 include PublicActivity::Model
  tracked owner: ->(controller, model) { controller && controller.current_user }

  validates :name, uniqueness: {scope: :company_id}, presence: true, format: { with: /\A[a-zA-Z]+\z/ }

  has_many :departments
  belongs_to :company

end
