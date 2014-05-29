class Compliance < ActiveRecord::Base
    #publicactivity gem
   include PublicActivity::Model
   tracked owner: ->(controller, model) { controller && controller.current_user }
   tracked ip: ->(controller,model) {controller && controller.current_user.current_sign_in_ip}

	validates :name, presence:{message: MESSAGES["compliance"]["name"]["presence"]["failure"]}
    validates :name, uniqueness:{message: MESSAGES["compliance"]["name"]["uniqueness"]["failure"]}
end
