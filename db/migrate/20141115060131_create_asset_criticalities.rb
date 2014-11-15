class CreateAssetCriticalities < ActiveRecord::Migration
  def change
    create_table :asset_criticalities do |t|
      t.string :name

      t.timestamps
    end
  end
end
