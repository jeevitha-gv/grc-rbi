class Rating < ActiveRecord::Base
	has_many :investigations
end
