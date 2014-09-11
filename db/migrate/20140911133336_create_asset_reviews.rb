class CreateAssetReviews < ActiveRecord::Migration
  def change
    create_table :asset_reviews do |t|
      t.integer :asset_id
      t.integer :asset_decision_id
      t.text :closure_statement
      t.date :next_review

      t.timestamps
    end
  end
end
