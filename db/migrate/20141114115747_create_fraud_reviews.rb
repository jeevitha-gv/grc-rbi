class CreateFraudReviews < ActiveRecord::Migration
  def change
    create_table :fraud_reviews do |t|
      t.integer :fraud_id
      t.text :detection_strategy
      t.text :detection_method

      t.timestamps
    end
  end
end
