class CreateMgmtReviews < ActiveRecord::Migration
  def change
    create_table :mgmt_reviews do |t|
      t.integer :risk_id
      t.integer :review_id
      t.integer :reviewer
      t.integer :next_step_id

      t.timestamps
    end
  end
end
