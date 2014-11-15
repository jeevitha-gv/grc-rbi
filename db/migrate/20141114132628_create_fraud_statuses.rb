class CreateFraudStatuses < ActiveRecord::Migration
  def change
    create_table :fraud_statuses do |t|
      t.string :name

      t.timestamps
    end
  end
end
