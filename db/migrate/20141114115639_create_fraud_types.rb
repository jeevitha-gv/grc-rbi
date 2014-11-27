class CreateFraudTypes < ActiveRecord::Migration
  def change
    create_table :fraud_types do |t|
      t.integer :company_id
      t.text :name

      t.timestamps
    end
  end
end
