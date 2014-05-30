class CreateNcQuestions < ActiveRecord::Migration
  def change
    create_table :nc_questions do |t|
      t.string :question
      t.integer :audit_id
      t.integer :question_type_id
      t.integer :priority_id
      t.date :target_date
      t.boolean :does_require_document
      t.integer :company_id
      t.integer :auditee_id
      t.boolean :nc_library

      t.timestamps
    end
  end
end
