class PublishPolicy < ActiveRecord::Base
	
	# Associations
	belongs_to :policy
	has_many :publish_distribution_lists, :dependent => :destroy
	has_many :publish_emails, :dependent => :destroy
	accepts_nested_attributes_for :publish_emails, reject_if: lambda { |a| a[:email].blank? },:allow_destroy => true
	accepts_nested_attributes_for :publish_distribution_lists, reject_if: lambda { |a| a[:distribution_list_id].blank? },:allow_destroy => true


	# Validations
	validate  :check_email_uniquesness

	private

	def check_email_uniquesness
      if self.publish_emails.present?
        check_email = publish_emails.size == publish_emails.collect{|x| x.email}.uniq.size
        errors.add(:email, ("Please select unique Reviewer")) if(check_email == false)
      end
    end
end
