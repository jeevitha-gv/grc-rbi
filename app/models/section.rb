# The section Model is to track the Audit in the application.
class Section < ActiveRecord::Base
  validates :name, presence: true, format: { with: /\A[a-zA-Z]+\z/ }
  #associations
  has_many :modulars #Section has many modulars
end
