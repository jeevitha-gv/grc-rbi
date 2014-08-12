class ContractType < ActiveRecord::Base

#Associations with Asset Module
	has_many :contracts
end
