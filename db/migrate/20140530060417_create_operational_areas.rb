class CreateOperationalAreas < ActiveRecord::Migration
  def change
    create_table :operational_areas do |t|
      t.integer :compliance_library_id
      t.integer :weightage
      t.integer :company_id
      
      t.timestamps
    end
  end
end
