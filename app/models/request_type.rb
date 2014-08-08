class RequestType < ActiveRecord::Base
	
   	has_many :incidents

    validates :name, presence:true, length: { in: 0..50 }
	validates :name, uniqueness:true

end
