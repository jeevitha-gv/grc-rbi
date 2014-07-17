class RecommendationStatus < ActiveRecord::Base
    #publicactivity gem
   include PublicActivity::Model
   tracked owner: ->(controller, model) { controller && controller.current_user }
   tracked ip: ->(controller,model) {controller && controller.request.ip}
   has_many :checklist_recommendations


end
