class SubCategory < ActiveRecord::Base
	validates :name, uniqueness: true
end
