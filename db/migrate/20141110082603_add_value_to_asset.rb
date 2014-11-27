class AddValueToAsset < ActiveRecord::Migration
  def change
    add_column :assets, :value, :integer
  end
end
