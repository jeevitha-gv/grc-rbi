class Priority < ActiveRecord::Base
  validates_format_of :name, :with =>/\A[a-zA-Z1-9]+\z/
  validates :name, presence: true
  validates :name, uniqueness: true
end
