class CreateInformationAssets < ActiveRecord::Migration
  def change
    create_table :information_assets do |t|
      t.text :at_origin
      t.text :info_moved
      t.float :retention_period

      t.timestamps
    end
  end
end
