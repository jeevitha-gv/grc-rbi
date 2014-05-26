class Department < ActiveRecord::Base
  belongs_to :location

  validates :name, presence: true, uniqueness:{ message: MESSAGES["uniqueness"]["create"]["failure"]}
end
