class Artifact < ActiveRecord::Base

   include PublicActivity::Model
     tracked owner: ->(controller, model) { controller && controller.current_user }
     tracked ip: ->(controller,model) {controller && controller.request.ip}


  # Relationship
  belongs_to :compliance_library
  belongs_to :company
  has_many :artifact_answers

  # validation
  validates :name, uniqueness: {:scope => :compliance_library_id}, :if => Proc.new{ |f| !f.name.blank? }

  delegate :name, to: :compliance_library, prefix: true, allow_nil: true
end
