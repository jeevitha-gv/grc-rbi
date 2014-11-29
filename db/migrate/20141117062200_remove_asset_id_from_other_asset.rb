class RemoveAssetIdFromOtherAsset < ActiveRecord::Migration
  def change
    remove_column :other_assets, :asset_id, :integer
  end
end
