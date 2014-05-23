class Language < ActiveRecord::Base
  has_many :users
  
  scope :current_user_language, ->(id) {where("id = ?", id)}
end
