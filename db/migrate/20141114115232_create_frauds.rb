class CreateFrauds < ActiveRecord::Migration
  def change
    create_table :frauds do |t|
      t.integer :company_id
      t.string :subject
      t.string :control
      t.string :reference
      t.integer :location_id
      t.integer :fraud_type_id
      t.integer :technology_id
      t.integer :investigator
      t.integer :fraud_manager
      t.integer :team_id
      t.integer :fraud_status_id
      t.integer :person_responsible
      t.integer :investigation_object_id
      t.text :fraud_assessment
      t.integer :risk_value_id
      t.text :additional_note

      t.timestamps
    end
  end
end
