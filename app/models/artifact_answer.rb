class ArtifactAnswer < ActiveRecord::Base

# Relationship
 belongs_to :audit_compliance
 belongs_to :artifact
 belongs_to :responsibility , :class_name => "User"
 belongs_to :priority , :class_name => "Priority"


end
