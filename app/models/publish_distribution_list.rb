class PublishDistributionList < ActiveRecord::Base
	belongs_to :publish_policy
	belongs_to :distribution_list
end
