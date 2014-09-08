class CreateEscalations < ActiveRecord::Migration
  def change
    create_table :escalations do |t|
      t.integer :value
      t.integer :user
      t.integer :level
      t.integer :incident_priority_id
      t.time :time_line
      t.integer :mail_count
      t.string :to
      t.string :cc
      t.string :bcc

      t.timestamps
    end
        add_index :escalations, :user
        add_index :escalations, :incident_priority_id


  end
end
