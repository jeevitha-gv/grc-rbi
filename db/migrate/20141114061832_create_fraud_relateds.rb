class CreateFraudRelateds < ActiveRecord::Migration
  def change
    create_table :fraud_relateds do |t|
      t.string :name

      t.timestamps
    end
  end
end
