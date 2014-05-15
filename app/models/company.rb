class Company < ActiveRecord::Base
  belongs_to :country # Company belongs to a country
end
