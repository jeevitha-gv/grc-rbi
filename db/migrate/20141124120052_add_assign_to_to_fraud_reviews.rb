class AddAssignToToFraudReviews < ActiveRecord::Migration
  def change
    add_column :fraud_reviews, :assign_to, :integer
  end
end
