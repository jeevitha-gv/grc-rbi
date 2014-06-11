class ComplianceLibrary < ActiveRecord::Base

 # Relationship
 has_many :operational_areas
 belongs_to :compliance
 has_many :artifacts
 has_many :audit_compliances
 belongs_to :parent , :class_name => "ComplianceLibrary", foreign_key: "parent_id"

 #Validations
 validates :compliance_id, presence: true
 validates :name, presence: true

 before_destroy :child_compliance
 before_update :child_compliance_update

 delegate :name, to: :compliance, prefix: true, allow_nil: true
 delegate :parent_id, to: :compliance_library, prefix: true, allow_nil: true

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when '.csv' then Roo::CSV.new(file.path)
    when '.xlsx' then Roo::Excelx.new(file.path)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

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
