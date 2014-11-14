class PublishPolicy < ActiveRecord::Base
	
	# Associations
	belongs_to :policy
	has_many :publish_distribution_lists, :dependent => :destroy
	has_many :publish_emails, :dependent => :destroy
	accepts_nested_attributes_for :publish_emails, reject_if: lambda { |a| a[:email].blank? },:allow_destroy => true
	accepts_nested_attributes_for :publish_distribution_lists, reject_if: lambda { |a| a[:distribution_list_id].blank? },:allow_destroy => true
end
