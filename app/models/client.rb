class Client < ActiveRecord::Base

	belongs_to :company #client belongs to a company
	 validates_uniqueness_of :email, :presence => true#email should be unique
	 validates_uniqueness_of :name, :presence => true #client name should be unique
end
