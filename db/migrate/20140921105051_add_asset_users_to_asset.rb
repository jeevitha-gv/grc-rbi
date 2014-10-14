class AddAssetUsersToAsset < ActiveRecord::Migration
  def change
    add_column :assets, :asset_users, :string
  end
end
