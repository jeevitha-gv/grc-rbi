class CreateControlAudits < ActiveRecord::Migration
  def change
    create_table :control_audits do |t|
    	t.integer :control_id
    	t.integer :control_approval_id
    	t.integer :control_review_id
    	t.text :audit_metric_description
    	t.text :audit_success_criteria

      t.timestamps
    end
    add_index :control_audits, :control_id
    add_index :control_audits, :control_approval_id
    add_index :control_audits, :control_review_id
  end
end
