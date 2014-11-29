class Investigation < ActiveRecord::Base
	belongs_to :fraud
	belongs_to :closing
	belongs_to :finding
	belongs_to :rating

	belongs_to :assign, class_name: 'User', foreign_key: 'assign_for'
end
