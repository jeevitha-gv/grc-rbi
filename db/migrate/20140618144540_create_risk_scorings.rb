class CreateRiskScorings < ActiveRecord::Migration
  def change
    create_table :risk_scorings do |t|
      t.integer :risk_id
      t.string :scoring_type
      t.integer :scoring_id
      t.float :calculated_risk
      t.float :custom_value
      t.timestamps
    end
  end
end
