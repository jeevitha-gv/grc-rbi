class CreateAuditAuditees < ActiveRecord::Migration
  def change
    create_table :audit_auditees do |t|
      t.integer :user_id
      t.integer :audit_id

      t.timestamps
    end
  end
end
