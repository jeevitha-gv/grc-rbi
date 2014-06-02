class CreateAuditCompliances < ActiveRecord::Migration
  def change
    create_table :audit_compliances do |t|
      t.integer :compliance_library_id
      t.integer :audit_id
      t.integer :score_id
      t.boolean :is_answered , :default => false

      t.timestamps
    end
  end
end
