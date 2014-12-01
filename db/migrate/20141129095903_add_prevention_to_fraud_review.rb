class AddPreventionToFraudReview < ActiveRecord::Migration
  def change
    add_column :fraud_reviews, :prevention, :text
  end
end
