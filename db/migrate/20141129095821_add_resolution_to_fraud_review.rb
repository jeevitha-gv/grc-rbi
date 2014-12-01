class AddResolutionToFraudReview < ActiveRecord::Migration
  def change
    add_column :fraud_reviews, :resolution, :text
  end
end
