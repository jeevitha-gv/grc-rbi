class CreateBcAnalyses < ActiveRecord::Migration
  def change
    create_table :bc_analyses do |t|
      t.integer :company_id
      t.string :title
      t.integer :department_id
      t.integer :bu_process_id
      t.integer :threat_id
      t.integer :vulnerability_id
      t.text :threat
      t.text :vulnerability
      t.string :impact
      t.text :business_impact
      t.text :business_req
      t.text :tech_req
      t.text :recovery_req
      t.integer :confidentiality
      t.integer :availability
      t.integer :integrity
      t.integer :owner
      t.integer :manager
      t.text :assessment
      t.text :note

      t.timestamps
    end
  end
end
