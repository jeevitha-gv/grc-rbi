class Company < ActiveRecord::Base
  
  has_many :roles 
  belongs_to :country # Company belongs to a country
  validates_uniqueness_of :domain # Domain must be unique
  has_many :users
end
