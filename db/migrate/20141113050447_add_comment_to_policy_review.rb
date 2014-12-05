class AddCommentToPolicyReview < ActiveRecord::Migration
  def change
    add_column :policy_reviews, :comment, :string
  end
end
