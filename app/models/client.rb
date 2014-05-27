class Client < ActiveRecord::Base

	belongs_to :company #client belongs to a company
	 validates :name, presence: true, uniqueness:{ message: MESSAGES["uniqueness"]["create"]["failure"]}#name should be unique
	 validates :email, presence: true, uniqueness:{ message: MESSAGES["uniqueness"]["create"]["failure"]}#E-mailshould be unique
end
