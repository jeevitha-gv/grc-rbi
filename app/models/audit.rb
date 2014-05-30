class Audit < ActiveRecord::Base
	has_many :nc_questions
end
