class CreateInvestigations < ActiveRecord::Migration
  def change
    create_table :investigations do |t|
      t.integer :fraud_id
      t.text :summary
      t.integer :closing_id
      t.integer :finding_id
      t.integer :rating_id
      t.string :actual_loss

      t.timestamps
    end
  end
end
