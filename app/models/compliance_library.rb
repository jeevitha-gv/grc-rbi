class ComplianceLibrary < ActiveRecord::Base

 # Relationship
 has_many :operational_areas
 belongs_to :compliance
 has_many :artifacts
 has_many :audit_compliances

 #Validations
 validates :compliance_id, presence: true
 validates :name, presence: true
 
 before_destroy :child_compliance
 before_update :child_compliance_update

 delegate :name, to: :compliance, prefix: true, allow_nil: true
 delegate :parent_id, to: :compliance_library, prefix: true, allow_nil: true
 
 private
 def child_compliance
   control_objectives = ComplianceLibrary.where("parent_id= ?",id)
   control_objectives.each do |object|
      controls = ComplianceLibrary.where('parent_id= ?',object.id)
      controls.collect {|x| x.destroy}
      object.destroy
   end
  end
  
 def child_compliance_update
   control_objectives = ComplianceLibrary.where("parent_id= ?",id)
     control_objectives.each do |object|
      controls = ComplianceLibrary.where('parent_id= ?',object.id).update_all(compliance_id: compliance_id)
      end
   control_objectives.update_all(compliance_id: compliance_id)
 end
  
end
