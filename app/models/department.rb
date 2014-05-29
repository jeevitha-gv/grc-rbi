class Department < ActiveRecord::Base
  belongs_to :location

  validates_format_of :name, :with =>/\A[a-zA-Z1-9]+\z/
  validates :name, presence:true
  validates :location_id, presence:true
end
