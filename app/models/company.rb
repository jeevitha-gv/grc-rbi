class Company < ActiveRecord::Base
  belongs_to :country # Company belongs to a country
  validates_uniqueness_of :domain # Domain must be unique
end
