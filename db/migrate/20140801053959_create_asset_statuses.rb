class CreateAssetStatuses < ActiveRecord::Migration
  def change
    create_table :asset_statuses do |t|
      t.string :name

      t.timestamps
    end
  end
end
