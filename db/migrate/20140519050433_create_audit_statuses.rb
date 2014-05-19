class CreateAuditStatuses < ActiveRecord::Migration
  def change
    create_table :audit_statuses do |t|
      t.string :name
      t.timestamps
    end

    AuditStatus.create([{name: 'Planning'}])
    AuditStatus.create([{name: 'Initiated'}])
    AuditStatus.create([{name: 'In Progress'}])
    AuditStatus.create([{name: 'Closed'}])
    AuditStatus.create([{name: 'Halted'}])
    AuditStatus.create([{name: 'Cancelled'}])
  end
end
