class CreateRiskValues < ActiveRecord::Migration
  def change
    create_table :risk_values do |t|
      t.string :name

      t.timestamps
    end
  end
end
