class Language < ActiveRecord::Base
  has_many :users
  
  scope :current_user_language, ->(id) {where("id = ?", id)}

  validates :name, presence:{message: MESSAGES["language"]["name"]["presence"]["failure"]}
  validates :name, uniqueness:{message: MESSAGES["language"]["name"]["uniqueness"]["failure"]}
  validates :code, presence:{message: MESSAGES["language"]["code"]["presence"]["failure"]}
  validates :code, uniqueness:{message: MESSAGES["language"]["code"]["uniqueness"]["failure"]}
end
