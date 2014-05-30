class CreateAudits < ActiveRecord::Migration
  def change
    create_table :audits do |t|
      t.string :title
      t.text :scope
      t.text :context
      t.text :methodology
      t.text :deliverables
      t.string :issue
      t.integer :company_id
      t.integer :audit_type_id
      t.integer :audit_status_id
      t.string :compliance_type
      t.integer :standard_id
      t.integer :location_id
      t.integer :department_id
      t.integer :team_id
      t.date :start_date
      t.date :end_date
      t.integer :auditor
      t.text :objective
      t.integer :client_id
      t.text :close_reason
      t.integer :risk_id
      t.text :observation

      t.timestamps
    end
  end
end
