class CreateReviewActions < ActiveRecord::Migration
  def change
    create_table :review_actions do |t|
      t.string :name
      t.timestamps
    end
  end
end
