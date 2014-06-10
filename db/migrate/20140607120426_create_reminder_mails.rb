class CreateReminderMails < ActiveRecord::Migration
  def change
    create_table :reminder_mails do |t|
      t.string :mail_type
      t.integer :mail_id
      t.integer :mail_count

      t.timestamps
    end
  end
end
