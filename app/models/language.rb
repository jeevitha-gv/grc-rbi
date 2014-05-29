class Language < ActiveRecord::Base
  has_many :users
  
  scope :current_user_language, ->(id) {where("id = ?", id)}

  validates :name, presence:true
  validates :name, uniqueness:true
  validates :code, presence:true
  validates :code, uniqueness:true
end
