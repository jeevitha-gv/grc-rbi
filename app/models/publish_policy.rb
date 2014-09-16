class PublishPolicy < ActiveRecord::Base
	
	# Associations
	belongs_to :policy
	belongs_to :distribution_list

	has_many :publish_emails
end
