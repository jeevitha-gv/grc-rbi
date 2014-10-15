class AddFairPoliciesToAssetAction < ActiveRecord::Migration
  def change
    add_column :asset_actions, :fair_policies, :text
  end
end
