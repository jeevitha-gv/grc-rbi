class AuditType < ActiveRecord::Base
  #publicactivity gem
  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller && controller.current_user }
  tracked ip: ->(controller,model) {controller && controller.request.ip}

  # associations
  has_many :audits


end
