class AddFraudRelatedIdToControl < ActiveRecord::Migration
  def change
    add_column :controls, :fraud_related_id, :integer
  end
end
