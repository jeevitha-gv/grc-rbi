class Artifact < ActiveRecord::Base


  # Relationship
  belongs_to :compliance_library
  belongs_to :company
  has_many :artifact_answers

  delegate :name, to: :compliance_library, prefix: true, allow_nil: true
end
