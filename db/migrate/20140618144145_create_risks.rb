class CreateRisks < ActiveRecord::Migration
  def change
    create_table :risks do |t|
      t.string :subject
      t.string :control_number
      t.text :assessment
      t.text :notes
      t.integer :risk_status_id
      t.integer :reference
      t.integer :compliance_id
      t.integer :location_id
      t.integer :category_id
      t.integer :team_id
      t.integer :technology_id
      t.integer :owner
      t.date :review_date
      t.integer :project_id
      t.integer :submitted_by
      t.integer :risk_approval_status_id
      t.integer :company_id
      t.integer :risk_model_id

      t.timestamps
    end
  end
end
