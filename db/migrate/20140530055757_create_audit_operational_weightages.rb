class CreateAuditOperationalWeightages < ActiveRecord::Migration
  def change
    create_table :audit_operational_weightages do |t|
      t.integer :operational_area_id
      t.integer :audit_id
      t.integer :weightage
      t.integer :total_score
      t.integer :percentage
      
      t.timestamps
    end
  end
end
