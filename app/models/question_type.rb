class QuestionType < ActiveRecord::Base
  #publicactivity gem
    include PublicActivity::Model
    tracked owner: ->(controller, model) { controller && controller.current_user }
    tracked ip: ->(controller,model) {controller && controller.current_user.current_sign_in_ip}

  validates_format_of :name, :with =>/\A[a-zA-Z1-9]+\z/
  validates :name, presence:true
  validates :name, uniqueness:true
end
