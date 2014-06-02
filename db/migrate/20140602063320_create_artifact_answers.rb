class CreateArtifactAnswers < ActiveRecord::Migration
  def change
    create_table :artifact_answers do |t|
      t.integer :audit_compliance_id
      t.integer :artifact_id
      t.integer :responsibility_id
      t.date 	:target_date
      t.integer :priority_id

      t.timestamps
    end
  end
end
